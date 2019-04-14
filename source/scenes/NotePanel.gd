extends Panel

func _ready():
	$CloseButton.text = Globals.translate($CloseButton.text)

func set_text(message_key):
	$Label.text = Globals.translate(message_key)

func _on_CloseButton_pressed():
	self.queue_free()