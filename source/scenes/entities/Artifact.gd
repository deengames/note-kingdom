extends MeshInstance

export var rotate_x:int = 15
export var rotate_y:int = 30
export var rotate_z:int = 45

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees.x += (rotate_x * delta)
	rotation_degrees.y += (rotate_y * delta)
	rotation_degrees.z += (rotate_z * delta)