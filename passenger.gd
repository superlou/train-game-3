extends CharacterBody2D

var movement_speed: float = 30.0
@export var movement_target_position: Vector2 = Vector2(400, 75)

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var Facing = $FaceDirectionC.Facing


func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	call_deferred("actor_setup")
	$Sprite.play()


func actor_setup():
	await get_tree().physics_frame
	set_movement_target(movement_target_position)


func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target


func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		if $Sprite.animation.begins_with("walk"):
			$Sprite.animation = $Sprite.animation.replace("walk", "idle")
	else:
		var current_pos: Vector2 = global_position
		var next_pos: Vector2 = navigation_agent.get_next_path_position()

		var new_velocity: Vector2 = next_pos - current_pos
		new_velocity = new_velocity.normalized() * movement_speed
		velocity = new_velocity
		move_and_slide()

		match $FaceDirectionC.facing:
			Facing.RIGHT:
				$Sprite.animation = "walk_right"
			Facing.LEFT:
				$Sprite.animation = "walk_left"
			Facing.UP:
				$Sprite.animation = "walk_up"
			Facing.DOWN:
				$Sprite.animation = "walk_down"