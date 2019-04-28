extends CanvasLayer

var DiaryPanel = preload("res://scenes/DiaryPanel.tscn")
const SaveManager = preload("res://scripts/SaveManager.gd")
const VolumeHelper = preload("res://scripts/VolumeHelper.gd")

func _ready():
	$SaveGame.volume_db = VolumeHelper.get_volume(Globals.sfx_volume)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Chain of code to add or delete DiaryPanel
	if Input.is_action_just_pressed("open_close_diary"):
		self._on_toggle_diary()

func _on_toggle_diary():
	# DiaryPanelContainer should store only "DiaryPanel" or do not store anything at all
	var diary_panel_container_children = $DiaryPanelContainer.get_children()
	# If DiaryPanelContainer already store something
	if len(diary_panel_container_children) > 0:
		diary_panel_container_children[0].queue_free()
	else:
		var panel = DiaryPanel.instance()
		$DiaryPanelContainer.add_child(panel)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		# Save game
		$SaveGame.play()
		var save_data = {
			"last_room": Globals.last_room,
			"current_room": Globals.current_room,
			"notes_collected": Globals.notes_collected
		}
		SaveManager.save(SaveManager.SAVE_FILE_NAME, save_data)