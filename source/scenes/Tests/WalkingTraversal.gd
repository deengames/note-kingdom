extends Spatial


func _on_StaticBody_got_note(note):
	# TODO: set content based on note
	$NotePanel.visible = true
	$NotePanel/Label.text = note.text
	note.queue_free()
	self.remove_child(note)