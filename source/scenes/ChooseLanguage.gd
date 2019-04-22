extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_EnglishLanguage_pressed():
	Globals.set_language("en-US")
	queue_free()

func _on_RussianLanguage_pressed():
	Globals.set_language("ru-RU")
	queue_free()
	
func _on_HindiLanguage_pressed():
	Globals.set_language("hi-HI")
	queue_free()