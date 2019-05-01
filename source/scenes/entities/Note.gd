extends Area

const NotePanel = preload("res://scenes/NotePanel.tscn")
const Player = preload("res://scenes/entities/Player.gd")

signal got_note

export var note_key: int

const _ROTATE_SPEED = 100
var _current_angle: float = 0

func _ready():
	# In notes_collected we store only note_key. Check if we already got this note.
	# When you load (not sure about when you don't), note_key is an int, and Globals.notes_collected
	# has floats. So to normalize, convert all to ints and compare. Don't use .find.
	var already_collected = false
	for found_key in Globals.notes_collected:
		if int(found_key) == note_key:
			already_collected = true
			break
	
	if already_collected:
		get_parent().remove_child(self)
		self.queue_free()

func _process(delta):
	self._current_angle += (_ROTATE_SPEED * delta)
	self.rotation_degrees.y = self._current_angle
	#$MeshInstance2.get_surface_material(0).uv1_offset = Vector3($MeshInstance2.get_surface_material(0).uv1_offset.x + delta * 2, $MeshInstance2.get_surface_material(0).uv1_offset.y, 0)


func _on_StaticBody_body_entered(body):
	if body is Player and self.visible:
		#$AudioStreamPlayer.play()
		hide()

		var note_panel = NotePanel.instance()
		note_panel.set_text("NOTE_%s" % note_key)
				
		Globals.notes_collected.append(note_key)
	
		# we need to instatiate the GUI from code first, otherwise this breaks depending on
		# where you pick up a note
		
		body.get_node("GUI").get_node("NotePanelContainer").add_child(note_panel)

		#yield($AudioStreamPlayer, "finished")
		self.queue_free()