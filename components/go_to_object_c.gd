class_name GoToObject
extends Node2D

var movement_speed: float = 30.0

@export var object: Node2D = null
@export var face_direction_c: FaceDirectionC = null
@export var navigation_agent: NavigationAgent2D = null
@export var sprite: AnimatedSprite2D = null

@onready var actor = get_parent()

var Facing = FaceDirectionC.Facing
var moving := false


func _ready():
	call_deferred("setup_target")


func setup_target():
	await get_tree().physics_frame
	

func _physics_process(_delta):
	if object == null:
		return

	if navigation_agent.target_position != object.global_position:
		navigation_agent.target_position = object.global_position

	if navigation_agent.is_navigation_finished():
		moving = false
		if sprite.animation.begins_with("walk"):
			sprite.animation = sprite.animation.replace("walk", "idle")
	else:
		moving = true
		var current_pos: Vector2 = global_position
		var next_pos: Vector2 = navigation_agent.get_next_path_position()

		var new_velocity: Vector2 = next_pos - current_pos
		new_velocity = new_velocity.normalized() * movement_speed
		actor.velocity = new_velocity
		actor.move_and_slide()

		match face_direction_c.facing:
			Facing.RIGHT:
				sprite.animation = "walk_right"
			Facing.LEFT:
				sprite.animation = "walk_left"
			Facing.UP:
				sprite.animation = "walk_up"
			Facing.DOWN:
				sprite.animation = "walk_down"            
