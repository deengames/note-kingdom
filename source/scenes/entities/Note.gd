extends Area

const Player = preload("res://scenes/entities/Player.gd")

signal got_note

export var text:String = ""

const _ROTATE_SPEED = 100
var _current_angle:float = 0

func _process(delta):
	self._current_angle += (_ROTATE_SPEED * delta)
	self.rotation_degrees.y = self._current_angle
	$MeshInstance2.get_surface_material(0).uv1_offset = Vector3($MeshInstance2.get_surface_material(0).uv1_offset.x + delta * 10, $MeshInstance2.get_surface_material(0).uv1_offset.y + delta * 3, 0)


func _on_StaticBody_body_entered(body):
	if body is Player:
		self.get_parent().remove_child(self)
		self.queue_free()
		emit_signal("got_note", self)
