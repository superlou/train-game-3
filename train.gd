extends Node2D

@export var velocity = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):
	$Track.position.x -= velocity * delta

	if $Track.position.x < -32*2:
		$Track.position.x = 0

