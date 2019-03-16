extends Area

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2_body_entered(body):
	if body.name == "KinematicBody":
		get_node("/root/Spatial/TextEdit").visible = true

func _on_Area2_body_exited(body):
	if body.name == "KinematicBody":
		get_node("/root/Spatial/TextEdit").visible = false

func _on_Button_pressed():
	if get_node("/root/Spatial/TextEdit").text == "6":
		get_node("/root/Spatial/Label").visible = true
		get_node("/root/Spatial/Label").text = "You win!"
	pass # Replace with function body.
