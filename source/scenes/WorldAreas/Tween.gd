extends Tween

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	interpolate_property(get_parent(), "rotation:y", 0, PI , 5.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	start()