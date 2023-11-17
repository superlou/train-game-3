class_name EatBehavior
extends Behavior


@export var hungry_effect := -0.1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_effects(_actor):
	return {
		"Hungry": hungry_effect
	}


func get_actions(_actor):
	var smart_object = null # todo. The parent of the behavior?
	return [
		["go-beside", smart_object],
		["pick-up", smart_object],
		["eat", smart_object]
	]
