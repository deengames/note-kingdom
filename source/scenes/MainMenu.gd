extends Node2D

const SaveManager = preload("res://scripts/SaveManager.gd")
const SettingsPanel = preload("res://scenes/SettingsPanel.tscn")

func _ready():
	_on_picked_language() # set in globals on startup
	# Check if save file exists. Enable Load button if so.
	$ButtonsContainer/LoadButton.disabled = not File.new().file_exists(SaveManager.SAVE_FILE_NAME)
		
func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/WorldAreas/KingdomEntrance.tscn")

func _on_picked_language():
	var language_font = Globals.get_language_font()
	$ButtonsContainer/PlayButton.add_font_override("font", language_font)
	$ButtonsContainer/LoadButton.add_font_override("font", language_font)
	$ButtonsContainer/SettingsButton.add_font_override("font", language_font)
	$ButtonsContainer/CreditsButton.add_font_override("font", language_font)
	$ButtonsContainer/ExitButton.add_font_override("font", language_font)
	
	$ButtonsContainer/PlayButton.text = Globals.translate("NEW_GAME")
	$ButtonsContainer/LoadButton.text = Globals.translate("LOAD_GAME")
	$ButtonsContainer/SettingsButton.text = Globals.translate("SETTINGS")
	$ButtonsContainer/CreditsButton.text = Globals.translate("CREDITS")
	$ButtonsContainer/ExitButton.text = Globals.translate("EXIT")

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_SettingsButton_pressed():
	var settings_panel = SettingsPanel.instance()
	add_child(settings_panel)
	settings_panel.connect("picked_language", self, "_on_picked_language")

func _on_LoadButton_pressed():
	var data = SaveManager.load(SaveManager.SAVE_FILE_NAME)
	if data["current_room"] == null or data["current_room"] == "":
		data["current_room"] = "KingdomEntrance"
	
	Globals.last_room = data["last_room"]
	Globals.current_room = data["current_room"]
	Globals.notes_collected = data["notes_collected"]
	
	# Teleport to the last known room. Assumes all .tscns are in the same location
	var map_name = Globals.current_room.replace(" ", "")
	var scene_path = "res://scenes/WorldAreas/" + map_name + ".tscn"
	get_tree().change_scene(scene_path)
