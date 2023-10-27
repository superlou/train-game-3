extends Node2D


@export var fuel_gauge := 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$FuelGauge.text = "%d" % (fuel_gauge * 100) + "%"


func _on_see_interior_area_body_exited(body:Node2D):
	if body.name == "Player":
		var tween = get_tree().create_tween()
		tween.tween_property($Exterior, "modulate", Color.WHITE, 0.2)
		$Interior.tile_set.set_physics_layer_collision_layer(0, 0)
		$Exterior.tile_set.set_physics_layer_collision_layer(0, 1)


func _on_see_interior_area_body_entered(body:Node2D):
	if body.name == "Player":
		var tween = get_tree().create_tween()
		tween.tween_property($Exterior, "modulate", Color(0, 0, 0, 0), 0.2)
		$Interior.tile_set.set_physics_layer_collision_layer(0, 1)
		$Exterior.tile_set.set_physics_layer_collision_layer(0, 0)
