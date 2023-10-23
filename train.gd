extends Node2D


@export var velocity = 500
var reparenting_watches = []
var leaving_train_watches = []
@export var player: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player = %Player
	for car in %Cars.get_children():
		car.connect("body_entered", func(b): _on_body_entered(b, car))
		car.connect("body_exited", func(b): _on_body_exited(b, car))


func _process(_delta):
	%Camera.global_position = player.global_position


func _physics_process(delta):
	$Track.position.x -= velocity * delta

	if $Track.position.x < -32*2:
		$Track.position.x = 0

	_handle_reparenting()
	_handle_leaving_train()
	
	for child in %Ground.get_children():
		child.position.x -= velocity * delta

	var dist_from_broadcast := player.global_position.distance_to(%Broadcast.global_position)
	if dist_from_broadcast > 1000:
		respawn()


func _handle_reparenting():
#	if len(reparenting_watches) > 0:
#		print("Reparenting watches: ", reparenting_watches)

	var remaining_watches = []
	
	for body in reparenting_watches:
		var containing_cars = %Cars.get_children().filter(func(car): return car.contains(body))

		if len(containing_cars) == 1:
			var new_parent = containing_cars[0]
			if body.get_parent() != new_parent:
				body.reparent(new_parent)
		elif len(containing_cars) == 0:
			pass # Probably leaving the train. Don't track anymore
		else:
			remaining_watches.append(body)

	reparenting_watches = remaining_watches


func _handle_leaving_train():
	var remaining_watches = []

	for body in leaving_train_watches:
		var containing_cars = %Cars.get_children().filter(func(car): return car.contains(body))
		
		if len(containing_cars) == 0 and body.get_collision_layer_value(6):
			body.reparent(%Ground)
		else:
			remaining_watches.append(body)

	leaving_train_watches = remaining_watches


func _on_body_entered(body, car):
	# print("enter: ", body, car)
	if body.get_parent() != car and body not in reparenting_watches:
		reparenting_watches.append(body)


func _on_body_exited(body, _car):
	# print("exit: ", body, car)
	leaving_train_watches.append(body)


func respawn():
	player.global_position = %Respawn.global_position
