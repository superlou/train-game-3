class_name FaceDirectionC
extends Node

@onready var actor = get_parent()

enum Facing {
	RIGHT, LEFT, DOWN, UP
}

var facing := Facing.RIGHT


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if actor.velocity == Vector2.ZERO:
		return

	var angle = actor.velocity.angle()
	if angle > deg_to_rad(-70) and angle <= deg_to_rad(70):
		facing = Facing.RIGHT
	elif angle > deg_to_rad(70) and angle <= deg_to_rad(110):
		facing = Facing.DOWN
	elif angle > deg_to_rad(110) or angle < deg_to_rad(-110):
		facing = Facing.LEFT
	elif angle > deg_to_rad(-110) and angle <= deg_to_rad(-70):
		facing = Facing.UP
