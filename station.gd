extends Platform


# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func freeze_bodies():
	for child in get_all_children(self):
		if child is RigidBody2D:
			child.freeze = true 


func unfreeze_bodies():
	for child in get_all_children(self):
		if child is RigidBody2D:
			child.freeze = false 


func get_all_children(node) -> Array:
	var nodes : Array = []
	
	for N in node.get_children():
		if N.get_child_count() > 0:
			nodes.append(N)
			nodes.append_array(get_all_children(N))
		else:
			nodes.append(N)
	
	return nodes
		