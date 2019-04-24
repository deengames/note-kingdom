extends KinematicBody

export(bool) var pushable

var _GRAVITY = -40

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	move_and_slide(Vector3(0, _GRAVITY, 0), Vector3(0, 1, 0))