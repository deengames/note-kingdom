extends Area

const NotePanel = preload("res://scenes/NotePanel.tscn")
const Player = preload("res://scenes/entities/Player.gd")

signal got_note

export var note_key: int

const _ROTATE_SPEED = 100
var _current_angle: float = 0

func _process(delta):
	self._current_angle += (_ROTATE_SPEED * delta)
	self.rotation_degrees.y = self._current_angle
	#$MeshInstance2.get_surface_material(0).uv1_offset = Vector3($MeshInstance2.get_surface_material(0).uv1_offset.x + delta * 2, $MeshInstance2.get_surface_material(0).uv1_offset.y, 0)


func _on_StaticBody_body_entered(body):
	if body is Player:
		var note_panel = NotePanel.instance()
		Globals.notes_collected[note_key][0] = true # this may need to change
		note_panel.set_text("NOTE_%s" % note_key)
		
		var note_panel_container_children = get_node("/root/Location/GUI/NotePanelContainer").get_children(); 
		# NoteContainer should be used only to store one NotePanel at once 
		# If NoteContainer already store something
		if note_panel_container_children != []:
			note_panel_container_children[0].queue_free()
		get_node("/root/Location/GUI/NotePanelContainer").add_child(note_panel)
		
		self.queue_free()