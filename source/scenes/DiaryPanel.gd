extends Panel

var diary_panel_button = preload("res://scenes/DiaryPanelButton.tscn")

func _ready():
	$AudioStreamPlayer.play()
	$Tween.interpolate_property(self, "rect_position:y", self.rect_position.y, 0, 0.2, Tween.TRANS_EXPO,Tween.EASE_OUT)
	$Tween.start()
	$CloseButton.text = Globals.translate($CloseButton.text)
	
	# Breaks the style of the close button but makes it localizable
	var language_font = Globals.get_language_font()
	$Label.add_font_override("font", language_font)
	$CloseButton.add_font_override("font", language_font)
	
	# Adding notes buttons
	for i in Globals.notes_collected.size():
		var new_button = diary_panel_button.instance()
		var note_info = Globals.notes_collected[i]
		new_button.text = "Note%s" % i
		new_button.note_key = "NOTE_%s" % Globals.notes_collected[i]
		$Panel/VBoxContainer.add_child(new_button)

func set_text(message_key):
	$Label.text = Globals.translate(message_key)

func _on_CloseButton_pressed():
	self.queue_free()