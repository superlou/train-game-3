extends Node2D

signal body_entered
signal body_exited


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_bed_area_body_entered(body:Node2D):
	body_entered.emit(body)
	

func _on_bed_area_body_exited(body:Node2D):
	body_exited.emit(body)


func contains(body:Node2D):
	return $BedArea.overlaps_body(body)
