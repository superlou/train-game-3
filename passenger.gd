extends CharacterBody2D

@export var movement_target_position: Vector2 = Vector2(400, 75)

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var Facing = $FaceDirectionC.Facing


func _ready():
	call_deferred("actor_setup")
	$Sprite.play()


func actor_setup():
	await get_tree().physics_frame
	set_movement_target(movement_target_position)


func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target
