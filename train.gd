extends Node2D


@export var velocity = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	for car in %Cars.get_children():
		car.connect("body_entered", func(b): _on_body_entered(b, car))
		car.connect("body_exited", func(b): _on_body_exited(b, car))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Track.position.x -= velocity * delta

	if $Track.position.x < -32*2:
		$Track.position.x = 0


func _on_body_entered(body, car):
	print("enter: ", body, car)

	if body.get_parent() != car:
		body.get_parent().remove_child(body)
		car.add_child(body)



func _on_body_exited(body, car):
	print("exit:", body, car)