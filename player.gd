extends CharacterBody2D

@export var walk_speed = 100
@export var sprint_speed = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(_delta):
	var v = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed = sprint_speed if Input.is_action_pressed("sprint") else walk_speed
	velocity = v * speed
	move_and_slide()
	
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
