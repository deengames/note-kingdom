extends Area

export var number:int = 0

const Player = preload("res://scenes/entities/Player.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
			show()
		