extends Panel

signal picked_language

const SaveManager = preload("res://scripts/SaveManager.gd")

const _language_arrow_x = {
	"en-US": 380,
	"ru-RU": 630,
	"hi-HI": 880
}

func _ready():
	var language_font = Globals.get_language_font()
	$VBoxContainer/Label.add_font_override("font", language_font)
	$VBoxContainer/Label.text = Globals.translate("CHOOSE_LANGUAGE")
	
	$VBoxContainer/Button.add_font_override("font", language_font)
	$VBoxContainer/Button.text = Globals.translate("SAVE_AND_EXIT")
	
	_show_selected_language()

func _on_EnglishLanguage_pressed():
	Globals.set_language("en-US")
	_show_selected_language()
	emit_signal("picked_language")

func _on_RussianLanguage_pressed():
	Globals.set_language("ru-RU")
	_show_selected_language()
	emit_signal("picked_language")
	
func _on_HindiLanguage_pressed():
	Globals.set_language("hi-HI")
	_show_selected_language()
	emit_signal("picked_language")
	
func _show_selected_language():
	#$Language/UpArrow.position.x = _language_arrow_x[Globals._language]
	pass

func _on_SaveButton_pressed():
	var manager = SaveManager.new()
	var data = {'language': Globals._language}
	manager.save(manager.PREFERENCES_FILE_NAME, data)
	queue_free()