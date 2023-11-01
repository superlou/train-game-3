extends CharacterBody2D

@export var walk_speed = 100
@export var sprint_speed = 250

var held_item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


enum Facing {
	RIGHT, LEFT, DOWN, UP
}

var facing: Facing


func _physics_process(_delta):
	var v = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed = sprint_speed if Input.is_action_pressed("sprint") else walk_speed

	if Input.is_action_pressed("jump"):
		$JumpC.start_jump(v * speed)

	if not $JumpC.is_jumping:
		if v.x > 0:
			facing = Facing.RIGHT
			$Sprite.animation = "right"
			$Sprite.flip_h = false
		elif v.x < 0:
			facing = Facing.LEFT
			$Sprite.animation = "right"
			$Sprite.flip_h = true
		elif v.y > 0:
			facing = Facing.DOWN
			$Sprite.animation = "down"
			$Sprite.flip_h = false
		elif v.y < 0:
			facing = Facing.UP
			$Sprite.animation = "up"
			$Sprite.flip_h = false

		velocity = v * speed

	move_and_slide()

	if Input.is_action_just_pressed("interact"):
		interact()

	if held_item:
		held_item.global_position = current_hold_marker().global_position


func interact():
	if held_item:
		drop_held_item()
		return

	var interact_area = current_interact_area()
	var bodies = interact_area.get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			continue
		
		interact_with(body)
		break


func interact_with(item):
	if item.is_in_group("grabbable"):
		pick_up(item)
	

func pick_up(item):
	held_item = item
	item.set_collision_layer_value(6, false)
	item.reparent(self)


func drop_held_item():
#	held_item.global_position = current_hold_marker().global_position
	var pos = held_item.global_position
	remove_child(held_item)
	get_parent().add_child(held_item)
	held_item.global_position = pos
	held_item.set_collision_layer_value(6, true)
	held_item.rotation = 0	
	held_item = null


func current_interact_area():
	return {
		Facing.RIGHT: $InteractRight,
		Facing.LEFT: $InteractLeft,
		Facing.UP: $InteractUp,
		Facing.DOWN: $InteractDown,
	}[facing]


func current_hold_marker():
	return {
		Facing.RIGHT: %HoldMarkers/HoldRight,
		Facing.LEFT: %HoldMarkers/HoldLeft,
		Facing.UP: %HoldMarkers/HoldUp,
		Facing.DOWN: %HoldMarkers/HoldDown,
	}[facing]


func enable_low_collisions():
	set_collision_mask_value(2, true)


func disable_low_collisions():
	set_collision_mask_value(2, false)
