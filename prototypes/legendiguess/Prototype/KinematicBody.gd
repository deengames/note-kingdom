extends KinematicBody

var accel_x = 0
var accel_z = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_S):
		if accel_z < 10:
			accel_z += 1
	elif Input.is_key_pressed(KEY_W):
		if accel_z > -10:
			accel_z -= 1
	else:
		if accel_z > 0:
			accel_z -= 1
		if accel_z < 0:
			accel_z += 1
	
	if Input.is_key_pressed(KEY_D):
		if accel_x < 10 :
			accel_x += 1
	elif Input.is_key_pressed(KEY_A):
		if accel_x > -10:
			accel_x -= 1
	else:
		if accel_x > 0:
			accel_x -= 1
		if accel_x < 0:
			accel_x += 1
	
	move_and_slide(Vector3(200 * accel_x, 0, 200 * accel_z ) * delta)