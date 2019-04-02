extends KinematicBody

# Y-component is zero so we stay flat on the ground
export var move_speed:int = 200 # pixels per second?
var _acceleration:Vector3 = Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_S):
		self._acceleration.z = move_speed
	elif Input.is_key_pressed(KEY_W):
		self._acceleration.z = -move_speed
	else:
		self._acceleration.z = 0
	
	if Input.is_key_pressed(KEY_D):
		self._acceleration.x = move_speed
	elif Input.is_key_pressed(KEY_A):
		self._acceleration.x = -move_speed
	else:
		self._acceleration.x = 0
		
	move_and_slide(self._acceleration * delta)