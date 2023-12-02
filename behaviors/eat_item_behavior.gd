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


const GoToObject = preload("res://actions/go_to_object.gd")


func get_actions(actor):
	var smart_object = get_parent().get_parent()

	var go_to_object = GoToObject.new()
	go_to_object.face_direction_c = actor.get_node("FaceDirectionC")
	go_to_object.navigation_agent = actor.get_node("NavigationAgent2D")
	go_to_object.sprite = actor.get_node("Sprite")
	go_to_object.set_target_object(smart_object)

	return [
		go_to_object,
		# ["pick-up", smart_object],
		# ["eat", smart_object]
	]
