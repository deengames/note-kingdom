extends CanvasLayer

var diary_panel = preload("res://scenes/DiaryPanel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Chain of code to add or delete DiaryPanel
	if Input.is_action_just_pressed("open_close_diary"):
		# DiaryPanelContainer should store only "DiaryPanel" or do not store anything at all
		var diary_panel_container_children = $DiaryPanelContainer.get_children()
		# If DiaryPanelContainer already store something
		if diary_panel_container_children != []:
			diary_panel_container_children[0].queue_free()
		else:
			$DiaryPanelContainer.add_child(diary_panel.instance())