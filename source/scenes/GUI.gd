extends CanvasLayer

var DiaryPanel = preload("res://scenes/DiaryPanel.tscn")
const SaveManager = preload("res://scripts/SaveManager.gd")

func _ready():
	$SaveLabel.add_font_override("font", Globals.get_language_font())
	$SaveIndicator.text = Globals.translate("GAME_SAVED")#.replace("@key", "F")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Chain of code to add or delete DiaryPanel
	if Input.is_action_just_pressed("open_close_diary"):
		self._on_toggle_diary()
	if Input.is_action_just_pressed("save"):
		$SaveGame.play()
		$SaveIndicator.alpha = 1
		var save_data = {
			"last_room": Globals.last_room,
			"current_room": Globals.current_room,
			"notes_collected": Globals.notes_collected
		}
		SaveManager.save(SaveManager.SAVE_FILE_NAME, save_data)
	if Input.is_action_just_pressed("exit_to_main_menu"):
		var quit_panel = get_parent().get_node("CanvasLayer/QuitPanel")
		quit_panel.visible = not quit_panel.visible
		
func _on_toggle_diary():
	# DiaryPanelContainer should store only "DiaryPanel" or do not store anything at all
	var diary_panel_container_children = $DiaryPanelContainer.get_children()
	# If DiaryPanelContainer already store something
	if len(diary_panel_container_children) > 0:
		diary_panel_container_children[0].queue_free()
	else:
		var panel = DiaryPanel.instance()
		$DiaryPanelContainer.add_child(panel)

func _on_QuitButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_XButton_pressed():
	get_parent().get_node("CanvasLayer/QuitPanel").hide()
