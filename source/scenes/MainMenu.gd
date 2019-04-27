extends Node2D

const SettingsPanel = preload("res://scenes/SettingsPanel.tscn")


func _ready():
	_on_picked_language() # set in globals on startup
		
func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/WorldAreas/KingdomEntrance.tscn")

func _on_picked_language():
	var language_font = Globals.get_language_font()
	$ButtonsContainer/PlayButton.add_font_override("font", language_font)
	$ButtonsContainer/SettingsButton.add_font_override("font", language_font)
	$ButtonsContainer/CreditsButton.add_font_override("font", language_font)
	$ButtonsContainer/ExitButton.add_font_override("font", language_font)
	
	$ButtonsContainer/PlayButton.text = Globals.translate("PLAY")
	$ButtonsContainer/SettingsButton.text = Globals.translate("SETTINGS")
	$ButtonsContainer/CreditsButton.text = Globals.translate("CREDITS")
	$ButtonsContainer/ExitButton.text = Globals.translate("EXIT")

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_SettingsButton_pressed():
	var settings_panel = SettingsPanel.instance()
	add_child(settings_panel)
	settings_panel.connect("picked_language", self, "_on_picked_language")
