extends Node2D

const SettingsPanel = preload("res://scenes/SettingsPanel.tscn")

var _button_names = {}

func _ready():
	# Persist button keys because we translate them
	var buttons = [$ButtonsContainer/PlayButton, $ButtonsContainer/SettingsButton, $ButtonsContainer/CreditsButton, $ButtonsContainer/ExitButton]
	for button in buttons:
		_button_names[button] = button.text.to_upper().replace(" ", "_")
		
func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/WorldAreas/KingdomEntrance.tscn")

func _on_picked_language():
	var buttons = [$ButtonsContainer/PlayButton, $ButtonsContainer/SettingsButton, $ButtonsContainer/CreditsButton, $ButtonsContainer/ExitButton]
	for button in buttons:
		var key = _button_names[button]
		button.add_font_override("font", Globals.get_language_font())
		button.text = Globals.translate(key)

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_SettingsButton_pressed():
	var settings_panel = SettingsPanel.instance()
	add_child(settings_panel)
	settings_panel.connect("picked_language", self, "_on_picked_language")
