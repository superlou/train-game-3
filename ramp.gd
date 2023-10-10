extends Node2D


var deployed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func deploy():
	$AnimationPlayer.play("DeployRamp")


func set_deployed():
	deployed = true


func _on_traverse_body_entered(body:Node2D):
	if deployed and body is CollisionObject2D:
		body.set_collision_mask_value(2, false)
		body.set_collision_mask_value(3, false)


func _on_traverse_body_exited(body:Node2D):
	if body is CollisionObject2D:
		body.set_collision_mask_value(2, true)
		body.set_collision_mask_value(3, true)

