extends CharacterBody2D

@export var movement_target_position: Vector2 = Vector2(400, 75)

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var Facing = $FaceDirectionC.Facing


func _ready():
	$Sprite.play()
