extends Spatial

func _on_StaticBody_got_note(note):
	# TODO: set content based on note
	$NotePanel.visible = true
	note.queue_free()
	self.remove_child(note)