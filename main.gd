extends Node2D


var Station = load("res://station.tscn")
var station = null

enum TravelType {
	TRAVELING,
	APPROACHING_STATION,
	AT_STATION,
	DEPARTING_STATION
}

var travel_state: TravelType = TravelType.TRAVELING

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("spawn_station"):
		station = Station.instantiate()
		station.position = Vector2(2000, -50)
		add_child(station)
		travel_state = TravelType.APPROACHING_STATION

	if travel_state == TravelType.APPROACHING_STATION:
		%Train.velocity = min(0.5 * (station.position.x - 200), %Train.velocity)
		if %Train.velocity < 1:
			travel_state = TravelType.AT_STATION
			%Train.velocity = 0
			$Train/Ramp/AnimationPlayer.play("DeployRamp")

	if station:
		station.position.x -= %Train.velocity * delta