extends Area

const NotePanel = preload("res://scenes/NotePanel.tscn")
const Player = preload("res://scenes/entities/Player.gd")

signal got_note

export var message_key:String = ""

const _ROTATE_SPEED = 100
var _current_angle:float = 0

func _process(delta):
	self._current_angle += (_ROTATE_SPEED * delta)
	self.rotation_degrees.y = self._current_angle
	#$MeshInstance2.get_surface_material(0).uv1_offset = Vector3($MeshInstance2.get_surface_material(0).uv1_offset.x + delta * 2, $MeshInstance2.get_surface_material(0).uv1_offset.y, 0)


func _on_StaticBody_body_entered(body):
	if body is Player:
		var note_panel = NotePanel.instance()
		Globals.notes_collected.append(message_key) # this may need to change
		note_panel.set_text(message_key)
		self.get_parent().add_child(note_panel)
		
		self.get_parent().remove_child(self)
		self.queue_free()
