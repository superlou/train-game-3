extends Node2D

@export var velocity := 500.0
const ROLLING_FRICTION := 10.0
@export var decoupled_cars = []


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
