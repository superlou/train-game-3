extends Node2D


@export var value := 0.0
@export var need_min := 0.0
@export var need_max := 1.0
@export var weight_curve:Curve


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func change(amount: float):
	value = clampf(value + amount, need_min, need_max)


func weight() -> float:
	return weight_curve.sample(value)


func calc_utility(effect: float) -> float:
	# Can always make things worse, but can't make things
	# better than how bad things are currently.
	if effect <= 0:
		effect = -min(-effect, value)

	return effect * weight()
