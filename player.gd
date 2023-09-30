extends CharacterBody2D

@export var walk_speed = 100
@export var sprint_speed = 250
@export var jump_height = 10

var is_jumping:bool = false
var jump_vec:Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


var g = -10
var jump_t = 0
var original_z = 0
var jump_v = 2.5

func _physics_process(delta):
	var v = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed = sprint_speed if Input.is_action_pressed("sprint") else walk_speed

	if Input.is_action_pressed("jump") and not is_jumping:
		is_jumping = true
		jump_vec = v
		jump_t = 0
		original_z = $Sprite.position.y
		disable_low_collisions()
		velocity = v * speed
	
	if is_jumping:
		jump_t += delta
		$Sprite.position.y -= round(g * jump_t + jump_v)

		if $Sprite.position.y >= original_z:
			$Sprite.position.y = original_z
			is_jumping = false
			enable_low_collisions()
	else:	
		if v.x > 0:
			$Sprite.animation = "right"
			$Sprite.flip_h = false
		elif v.x < 0:
			$Sprite.animation = "right"
			$Sprite.flip_h = true
		elif v.y > 0:
			$Sprite.animation = "down"
			$Sprite.flip_h = false
		elif v.y < 0:
			$Sprite.animation = "up"
			$Sprite.flip_h = false

		velocity = v * speed

	move_and_slide()


func enable_low_collisions():
	set_collision_mask_value(2, true)


func disable_low_collisions():
	set_collision_mask_value(2, false)