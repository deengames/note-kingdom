extends Area

export var number:int = 0

const Player = preload("res://scenes/entities/Player.gd")
const VolumeHelper = preload("res://scripts/VolumeHelper.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.volume_db = VolumeHelper.get_volume(Globals.sfx_volume)
	
	# color change here using a shader
	
	var add_color = Color()
	if fmod(number, 3) == 0:
		add_color = Color(number, 0, 0)
	elif fmod(number, 2) == 0:
		add_color = Color(0, number, 0)
	else:
		add_color = Color(0, 0, number)
	$CSGTorus.material.set("shader_param/color_added", add_color)
#	$Post.get_surface_material(1).set("shader_param/color_added", add_color)
#	$Post2.get_surface_material(1).set("shader_param/color_added", add_color)
#	$Post4.get_surface_material(1).set("shader_param/color_added", add_color)
	# apply the material to each of the key mesh components
	$Post.set_surface_material(0, $CSGTorus.material)
	$Post2.set_surface_material(0, $CSGTorus.material)
	$Post3.set_surface_material(0, $CSGTorus.material)
	

func _process(delta):
	self.rotation_degrees.y += (100 * delta)

func _on_Area_body_entered(body):
	if body is Player:
		
		$AudioStreamPlayer.play()
		hide()
		
		if body.keys.size() < 1:
			body.keys.append(number)
			# Yielding immediately sometimes doesn't play the key sound.
			# Like, on the first key you pick up - buffering?
			yield($AudioStreamPlayer, "finished")
			self.queue_free()
		else:
			var number_switch = body.keys[0]
			body.keys = [self.number]
			self.number = number_switch
			hide()
			yield(self, "body_exited")
			_ready()
			show()
		