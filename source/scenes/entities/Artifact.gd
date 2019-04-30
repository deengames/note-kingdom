extends MeshInstance

export var rotate_x:int = 15
export var rotate_y:int = 30
export var rotate_z:int = 45

onready var player = get_parent().get_parent().get_node("KinematicBody")
onready var fadeAnim = get_parent().get_parent().get_node("KinematicBody/PlayerCharacter/Fade")

var touched:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	fadeAnim.play("Fade", -1, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees.x += (rotate_x * delta)
	rotation_degrees.y += (rotate_y * delta)
	rotation_degrees.z += (rotate_z * delta)
	
	# also, hacky, but make the player less visible somehow?
	if not touched:
		fadeAnim.seek(abs(inverse_lerp(0, translation.z, player.translation.z)) * 0.5, true)

func _on_Area_body_entered(body):
	if not touched:
		touched = true
		body.set_physics_process(false)
		player.get_node("PlayerCharacter/AnimationPlayer").stop()
		fadeAnim.play("Fade", 0.2, 0.2)
		yield(fadeAnim, "animation_finished")
		player.get_node("GUI/AnimationPlayer").play("ScreenFade", -1, -0.3, true)
		yield(player.get_node("GUI/AnimationPlayer"), "animation_finished")
		get_tree().change_scene("res://scenes/MainMenu.tscn") # this probably needs to be credits
