extends Panel

signal picked_language

func _on_EnglishLanguage_pressed():
	Globals.set_language("en-US")
	emit_signal("picked_language")
	queue_free()

func _on_RussianLanguage_pressed():
	Globals.set_language("ru-RU")
	emit_signal("picked_language")
	queue_free()
	
func _on_HindiLanguage_pressed():
	Globals.set_language("hi-HI")
	emit_signal("picked_language")
	queue_free()