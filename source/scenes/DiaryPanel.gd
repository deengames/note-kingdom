extends Panel

func _ready():
	$Tween.interpolate_property(self, "rect_position:y", self.rect_position.y, 0, 0.5, Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
	$Tween.start()
	$CloseButton.text = Globals.translate($CloseButton.text)
	
	# Breaks the style of the close button but makes it localizable
	var language_font = Globals.get_language_font()
	$Label.add_font_override("font", language_font)
	$CloseButton.add_font_override("font", language_font)
	
func set_text(message_key):
	$Label.text = Globals.translate(message_key)

func _on_CloseButton_pressed():
	self.queue_free()