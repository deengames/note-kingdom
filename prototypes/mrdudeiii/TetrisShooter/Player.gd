extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 300
export var snap = Vector2(20, 20)
export var clipSize = 4
export var recoil = 0.1
var bullets_list = [
	load("res://One.tscn"),
	load("res://TwoLine.tscn"),
	load("res://ThreeCorner.tscn"),
	load("res://ThreeLine.tscn")
	]
var ready = []
var shifting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.

func _process(delta):
	var control_direction = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
		)
	var control_rotation = int(Input.is_action_just_pressed("turn_clockwise")) - int(Input.is_action_just_pressed("turn_counterclockwise"))
	if ready.size() > 0 and ready[0].global_position.x > global_position.x:
		if control_rotation:
			ready[0].rotate_group(control_rotation)
		if Input.is_action_just_pressed("ui_select"):
			shoot()
	if ready.size() < 1:
		generate_new_bullets()
	if not control_direction:
		global_position = global_position.snapped(Vector2(0, 20))
		return
	move_and_slide(control_direction * speed)

func shoot():
	ready.pop_front().shoot()
	yield(get_tree().create_timer(recoil), "timeout")
	if not ready[0].global_position.x > global_position.x:
		shift_bullets()

func generate_new_bullets():
	for i in range(clipSize):
		var obj = bullets_list.pop_front()
		bullets_list.append(obj)
		obj = obj.instance()
		ready.append(obj)
		print(ready)
		obj.position.x = obj.position.x - 80 * (i + 1)
		add_child(obj)
	yield(get_tree().create_timer(0.4), "timeout")
	if not ready[0].global_position.x > global_position.x:
		shift_bullets()

func shift_bullets():
	if not shifting:
#		print("ready is " + str(ready) + " at the start")
#		print("shifting bullets")
		shifting = true
		var first = true
		for i in ready:
			if first:
#				print("first!")
				i.position.x += 160
				first = false
			else:
#				print("not first")
				i.position.x += 80
#		print("ready is " + str(ready) + " at the end")
	shifting = false
	

