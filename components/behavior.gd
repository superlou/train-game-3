class_name Behavior
extends Node2D


@onready var smart_object = get_parent().get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_effects(_actor):
	return {}


func get_actions(_actor):
	return []
