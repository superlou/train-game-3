extends Node2D

@export var player: Node2D = null
var reparenting_watches = []
var leaving_train_watches = []

var Station = load("res://station.tscn")
var station = null

enum TravelType {
	TRAVELING,
	APPROACHING_STATION,
	AT_STATION,
	DEPARTING_STATION
}

var travel_state: TravelType = TravelType.TRAVELING

# Called when the node enters the scene tree for the first time.
func _ready():
	player = %Player

	for car in %Cars.get_children():
		car.connect("platform_entered", func(b): _on_body_entered(b, car))
		car.connect("platform_exited", func(b): _on_body_exited(b, car))


func _process(_delta):
	%Camera.global_position = player.global_position


func _physics_process(delta):
	if Input.is_action_just_pressed("spawn_station"):
		station = Station.instantiate()
		station.position = Vector2(2000, -50)
		add_child(station)
		travel_state = TravelType.APPROACHING_STATION

		station.connect("platform_entered", func(b): _on_body_entered(b, station))
		station.connect("platform_exited", func(b): _on_body_exited(b, station))

	if travel_state == TravelType.APPROACHING_STATION:
		%Train.velocity = min(0.5 * (station.position.x - 200), %Train.velocity)
		station.freeze_bodies()
		if %Train.velocity < 1:
			travel_state = TravelType.AT_STATION
			%Train.velocity = 0
			%Train/Cars/Flatbed1/Ramp.deploy()
			station.unfreeze_bodies()

	_handle_reparenting()
	_handle_leaving_train()

	if station:
		station.position.x -= %Train.velocity * delta

	for child in %Ground.get_children():
		# todo This doesn't really work because of physics!
		child.position.x -= %Train.velocity * delta
		print(%Train.velocity * delta)

	var dist_from_broadcast := player.global_position.distance_to(%Broadcast.global_position)
	if dist_from_broadcast > 1500:
		respawn()


func _containing_platforms(body):
	var platforms = %Cars.get_children().filter(func(car): return car.contains(body))
	if station and station.contains(body):
		platforms.append(station)
	
	return platforms


func _handle_reparenting():
	var remaining_watches = []
	
	for body in reparenting_watches:
		var containing_platforms = _containing_platforms(body)

		if len(containing_platforms) == 1:
			var new_parent = containing_platforms[0]
			if body.get_parent() != new_parent:
				body.reparent(new_parent)
		elif len(containing_platforms) == 0:
			pass # Probably leaving the train. Don't track anymore
		else:
			remaining_watches.append(body)

	reparenting_watches = remaining_watches
	
	
func _handle_leaving_train():
	var remaining_watches = []

	for body in leaving_train_watches:
		var containing_platforms = _containing_platforms(body)	
		
		if len(containing_platforms) == 0 and body.get_collision_layer_value(6):
			body.reparent(%Ground)
		else:
			remaining_watches.append(body)

	leaving_train_watches = remaining_watches


func _on_body_entered(body, platform):
	# print("enter: ", body, car)
	if body.get_parent() != platform and body not in reparenting_watches:
		reparenting_watches.append(body)


func _on_body_exited(body, _platform):
	# print("exit: ", body, car)
	leaving_train_watches.append(body)


func respawn():
	var tween = get_tree().create_tween()
	%Camera.position_smoothing_enabled = false
	tween.tween_property(%Camera/Curtain, "color", Color(0, 0, 0, 1), 0.5)
	tween.tween_interval(1)
	tween.tween_callback(func(): player.global_position = %Respawn.global_position)
	tween.tween_interval(1)
	tween.tween_property(%Camera/Curtain, "color", Color(0, 0, 0, 0), 0.5)
	tween.tween_callback(func(): %Camera.position_smoothing_enabled = true)
		
