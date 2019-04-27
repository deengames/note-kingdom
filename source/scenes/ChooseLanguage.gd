extends Panel

signal picked_language

const SaveManager = preload("res://scripts/SaveManager.gd")

const _language_arrow_x = {
	"en-US": 380,
	"ru-RU": 630,
	"hi-HI": 880
}

func _ready():
	_translate($VBoxContainer/Label, "CHOOSE_LANGUAGE")
	_translate($VBoxContainer/Button, "SAVE_AND_EXIT")
	_translate($VBoxContainer/Label2, "AUDIO_SETTINGS")
	_translate($VBoxContainer/MusicLabel, "MUSIC")
	_translate($VBoxContainer/SfxLabel, "SOUND_EFFECTS")
	
	_show_selected_language()

func _translate(control, message_key):
	var language_font = Globals.get_language_font()	
	control.add_font_override("font", language_font)
	control.text = Globals.translate(message_key)
	
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
	var data = {
		'language': Globals._language,
		'music_volume': Globals.music_volume,
		'sfx_volume': Globals.sfx_volume
	}
	manager.save(manager.PREFERENCES_FILE_NAME, data)
	queue_free()

func _on_SfxSlider_value_changed(value):
	Globals.sfx_volume = value

func _on_MusicSlider_value_changed(value):
	Globals.music_volume = $MusicSlider.value