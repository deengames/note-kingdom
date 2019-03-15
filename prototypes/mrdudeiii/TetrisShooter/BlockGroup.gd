extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)

func rotate_group(dir):
	rotate(PI * 0.5 * dir)

func shoot():
	var root = get_tree().get_root()
	var pos = global_position
	get_parent().remove_child(self)
	root.add_child(self)
	global_position = pos
#	for i in get_children():
		
#		i.apply_central_impulse(Vector2(500, 0))
	position = position.snapped(Vector2(0, 20))
	set_process(true)

#
func _process(delta):
	var c = null
	for i in get_children():
		c = i.move_and_collide(Vector2(400, 0) * delta)
		if c and not c.collider in self.get_children():
			for i in get_children():
				var pos = i.global_position
				i.set_process(false)
				remove_child(i)
				c.collider.get_parent().add_child(i)
				i.global_position = pos.snapped(Vector2(20, 20))
				i.check_clear()
			return

