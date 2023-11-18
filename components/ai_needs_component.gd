extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Hungry.change(delta * 0.01)
	$Tired.change(delta * 0.01)
	$Afraid.change(delta * 0.0)
	$Bored.change(delta * 0.01)
	$Gross.change(delta * 0.01)
	# print_info()


func print_info():
	print("---")
	for need in get_children():
		print(need.name, ": ", "%.2f" % need.value)

	print("Eat carefully: ", utility({
		"Hungry": -0.1,
	}))

	print("Eat sloppy: ", utility({
		"Hungry": -0.2,
		"Gross": 0.05
	}))

	print("Nap: ", utility({
		"Tired": -0.3
	}))

	print("Sleep: ", utility({
		"Tired": -1.0
	}))


func utility(effects: Dictionary):
	var utility := 0.0

	for need_name in effects:
		var need = get_node(need_name)
		utility += need.calc_utility(effects[need_name])

	return utility
