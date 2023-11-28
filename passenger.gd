extends CharacterBody2D

@export var movement_target_position: Vector2 = Vector2(400, 75)

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var Facing = $FaceDirectionC.Facing

var active_behavior = null
var action_queue := []
var active_action = null


func _ready():
	$Sprite.play()


func _process(_delta):
	if active_behavior == null:
		active_behavior = _find_new_behavior()
		action_queue = active_behavior.get_actions(self)
		print("new behavior: ", active_behavior)
	
	if active_behavior != null:
		_do_behavior()


func _find_new_behavior():
	var smart_object_behavior_sets = $SmartObjectsRefComponent.get_all()
	var behaviors = []
	for behavior_set in smart_object_behavior_sets:
		for behavior in behavior_set.all():
			behaviors.append(behavior)

	var ai_needs := $AINeedsComponent

	behaviors.sort_custom(func(a, b): \
	  return ai_needs.utility(a) > ai_needs.utility(b)
	)

	return behaviors[0]


func _do_behavior():
	if len(action_queue) == 0:
		active_behavior = null
		active_action = null
		return

	active_action = action_queue[0]
	match active_action:
		["go-to-object", var obj]:
			$GoToObjectC.object = obj
			if not $GoToObjectC.moving:
				# THIS DOESN"T WORK BECAUSE IMMEDIATELY NOT MOVING
				action_queue.pop_front()

