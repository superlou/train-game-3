extends CharacterBody2D

@export var walk_speed = 100
@export var sprint_speed = 250

@onready var Facing = $FaceDirectionC.Facing


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(_delta):
	var v = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed = sprint_speed if Input.is_action_pressed("sprint") else walk_speed

	if Input.is_action_pressed("jump"):
		$JumpC.start_jump(v * speed)

	if not $JumpC.is_jumping:
		velocity = v * speed

		match $FaceDirectionC.facing:
			Facing.RIGHT:
				$Sprite.animation = "right"
				$Sprite.flip_h = false
			Facing.LEFT:
				$Sprite.animation = "right"
				$Sprite.flip_h = true
			Facing.UP:
				$Sprite.animation = "up"
				$Sprite.flip_h = false
			Facing.DOWN:
				$Sprite.animation = "down"
				$Sprite.flip_h = false


	move_and_slide()

	if Input.is_action_just_pressed("interact"):
		interact()


func interact():
	if $CarryC.is_holding():
		$CarryC.drop()
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
		$CarryC.pick_up(item)
	

func current_interact_area():
	return {
		Facing.RIGHT: $InteractRight,
		Facing.LEFT: $InteractLeft,
		Facing.UP: $InteractUp,
		Facing.DOWN: $InteractDown,
	}[$FaceDirectionC.facing]


func enable_low_collisions():
	set_collision_mask_value(2, true)


func disable_low_collisions():
	set_collision_mask_value(2, false)
