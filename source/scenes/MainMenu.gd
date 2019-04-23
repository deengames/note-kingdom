extends Node2D

func _ready():
	$ChooseLanguage.connect("picked_language", self, "_on_picked_language")

func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/WorldAreas/KingdomEntrance.tscn")

func _on_picked_language():
		var buttons = [$ButtonsContainer/PlayButton, $ButtonsContainer/SettingsButton, $ButtonsContainer/CreditsButton, $ButtonsContainer/ExitButton]
		for button in buttons:
			var key = button.text.to_upper().replace(" ", "_")
			button.add_font_override("font", Globals.get_language_font())
			button.text = Globals.translate(key)