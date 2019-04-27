extends CanvasLayer

var DiaryPanel = preload("res://scenes/DiaryPanel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
		self._on_toggle_diary()