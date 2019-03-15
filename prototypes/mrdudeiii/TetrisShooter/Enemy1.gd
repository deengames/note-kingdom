extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if get_child_count() < 1:
		queue_free()
#	else:
#		for i in get_children():
#			i.move_and_collide(Vector2(-100, 0) * delta)
