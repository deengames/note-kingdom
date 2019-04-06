extends Area

const _ROTATE_SPEED = 100
var _current_angle:float = 0

func _process(delta):
	self._current_angle += (_ROTATE_SPEED * delta)
	self.rotation_degrees.y = self._current_angle


func _on_StaticBody_body_entered(body):
	# TODO: find a non-hacky way to do this
	var script = body.script
	if script.resource_path.index("/Player.gd") > -1:
		# touched the player
		pass
