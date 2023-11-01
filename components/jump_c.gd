class_name JumpC
extends Node

@export var g = -10
@export var jump_height = 10
@export var jump_z_velocity = 2.5

var jump_t = 0
var original_z = 0
var jump_ground_velocity:Vector2 = Vector2.ZERO
var is_jumping:bool = false

@onready var actor = get_parent()
@export var sprite:Node2D = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_jumping:
		return

	jump_t += delta
	var jump_offset = round(g * jump_t + jump_z_velocity)
	sprite.position.y -= jump_offset

	if sprite.position.y >= original_z:
		sprite.position.y = original_z
		is_jumping = false
		actor.enable_low_collisions()
		actor.set_collision_layer_value(6, true)

	actor.velocity = jump_ground_velocity


func start_jump(velocity: Vector2):
	if is_jumping:
		return

	is_jumping = true
	jump_ground_velocity = velocity
	jump_t = 0
	original_z = sprite.position.y
	actor.disable_low_collisions()
	actor.set_collision_layer_value(6, false)
