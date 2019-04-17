extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var location_label = get_node("/root/Location")
	
	if location_label != null:
		$Label.text = location_label.location_name
		get_node("../Tween").interpolate_property(self, "modulate:a", 1, 0, 3, Tween.TRANS_BACK, Tween.EASE_IN)
		get_node("../Tween").start()
	else:
		# Just viewing a single puzzle. Hide it.
		self.modulate = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Tween_tween_completed(object, key):
	$Label.queue_free()
	get_node("../Tween").reset_all()
	get_node("../Tween").queue_free()
	self.queue_free()