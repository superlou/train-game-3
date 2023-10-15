extends Node2D


@export var velocity = 500
var reparenting_watches = []
var leaving_train_watches = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for car in %Cars.get_children():
		car.connect("body_entered", func(b): _on_body_entered(b, car))
		car.connect("body_exited", func(b): _on_body_exited(b, car))


func _physics_process(delta):
	$Track.position.x -= velocity * delta

	if $Track.position.x < -32*2:
		$Track.position.x = 0

	_handle_reparenting()
	_handle_leaving_train()
	
	for child in %Ground.get_children():
		child.position.x -= velocity * delta


func _handle_reparenting():
#	if len(reparenting_watches) > 0:
#		print("Reparenting watches: ", reparenting_watches)

	var remaining_watches = []
	
	for body in reparenting_watches:
		var containing_cars = %Cars.get_children().filter(func(car): return car.contains(body))

		if len(containing_cars) == 1:
			var new_parent = containing_cars[0]
			if body.get_parent() != new_parent:
				var prev_pos = body.global_position
				body.get_parent().remove_child(body)
				new_parent.add_child(body)
				body.global_position = prev_pos
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
			var prev_pos = body.global_position
			body.get_parent().remove_child(body)
			%Ground.add_child(body)
			body.global_position = prev_pos			
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


func _on_player_moved(player_global_pos: Vector2):
	# Using a signal from the player is a hack for
	# https://github.com/godotengine/godot/issues/81480
	%Camera.global_position = player_global_pos
