extends Panel

signal picked_language

const _language_arrow_x = {
	"en-US": 380,
	"ru-RU": 630,
	"hi-HI": 880
}

func _ready():
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
	$Language/UpArrow.position.x = _language_arrow_x[Globals._language]