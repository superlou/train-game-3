extends Node2D

@export var velocity := 500.0
const ROLLING_FRICTION := 20.0
@export var decoupled_cars: Array[Platform] = []

@export var fuel_max := 5000.0
@export var fuel = 5000.0
@export var throttle = 1.0
@export var fuel_consumption_full_throttle = 1.0

func _ready():
	for car in %Cars.get_children():
		car.relative_velocity = 0


func _physics_process(delta):
	$Track.position.x -= velocity * delta

	if $Track.position.x < -32*2:
		$Track.position.x = 0

	for car in decoupled_cars:
		car.relative_velocity -= ROLLING_FRICTION * delta
		car.relative_velocity = max(car.relative_velocity, -velocity)

	for car in %Cars.get_children():
		car.position.x += car.relative_velocity * delta

	fuel -= fuel_consumption_full_throttle * throttle * delta
	fuel = clamp(fuel, 0.0, fuel_max)
	%ControlCrate.fuel_gauge = fuel / fuel_max

	if fuel == 0.0:
		velocity = max(velocity - ROLLING_FRICTION * delta, 0)
