extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	create_enemy()

func create_enemy():
	yield(get_tree().create_timer(1.0), "timeout")
	var obj = load("res://Enemy1.tscn")
	obj = obj.instance()
	get_parent().add_child(obj)
	obj.global_position = global_position
	yield(obj, "tree_exiting")
	create_enemy()