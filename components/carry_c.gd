class_name CarryC
extends Node


@onready var actor = get_parent()
@export var hold_left_pos: Marker2D
@export var hold_right_pos: Marker2D
@export var hold_up_pos: Marker2D
@export var hold_down_pos: Marker2D
@export var face_direction_c:FaceDirectionC
@onready var Facing = face_direction_c.Facing

var held_item = null


func _physics_process(_delta):
	if held_item:
		held_item.global_position = current_hold_marker().global_position


func is_holding():
	return held_item != null


func current_hold_marker():
	return {
		Facing.RIGHT: hold_right_pos,
		Facing.LEFT: hold_left_pos,
		Facing.UP: hold_up_pos,
		Facing.DOWN: hold_down_pos,
	}[face_direction_c.facing]


func pick_up(item):
	held_item = item
	item.set_collision_layer_value(6, false)
	item.reparent(actor)


func drop():
	if not is_holding():
		return

	held_item.reparent(actor.get_parent())
	held_item.global_position = current_hold_marker().global_position
	held_item.set_collision_layer_value(6, true)
	held_item.rotation = 0	
	held_item = null
