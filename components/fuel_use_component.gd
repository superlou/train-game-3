extends Node2D

@export var fuel_max := 5000.0
@export var fuel = 5000.0
@export var throttle = 1.0
@export var fuel_consumption_full_throttle = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	fuel -= fuel_consumption_full_throttle * throttle * delta
	fuel = clamp(fuel, 0.0, fuel_max)


func percent_full():
	return fuel / fuel_max


func is_empty():
	return fuel <= 0.0