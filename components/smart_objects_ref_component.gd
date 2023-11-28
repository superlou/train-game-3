extends Node2D


var known_smart_objects: Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_all():
	return get_tree().get_nodes_in_group("behavior-set")