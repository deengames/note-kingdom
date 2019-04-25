extends Spatial

export var number: int = 0

const Player = preload("res://scenes/entities/Player.gd")

var _base_y: float
var _total_elapsed: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self._base_y = $MeshInstance.translation.y # just the mesh

func _process(delta):
	if Globals.player.keys.find(number) == -1:
		_total_elapsed += delta
		$MeshInstance.translation.y = _base_y + 0.5 + cos(_total_elapsed)
	else:
		# Visual feedback: when player has the key, stop moving.
		translation.y = 1 # partially underground

func _on_Area_body_entered(body):
	if body is Player:
		var key_index = body.keys.find(self.number)
		if key_index > -1:
			body.keys.remove(key_index)
			$AudioStreamPlayer.play()
			# Disappear. Stop colliding, too.
			hide()
			remove_child($CollisionShape)
			yield($AudioStreamPlayer, "finished")
			self.queue_free()
