extends Node2D

@export var velocity := 500.0
const ROLLING_FRICTION := 20.0
@export var decoupled_cars: Array[Platform] = []
@onready var fuel = get_node("FuelUseComponent")


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

	%ControlCrate.fuel_gauge = fuel.percent_full()

	if fuel.is_empty():
		velocity = max(velocity - ROLLING_FRICTION * delta, 0)
