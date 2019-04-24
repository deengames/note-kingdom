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
		# If DiaryPanelContainer have DiaryPanel
		if diary_panel_container_children != []:
			var diary_panel_container_children_name = diary_panel_container_children[0].name
			# If soneome accidentally put not "DiaryPanel" node in DiaryPanelContainer this check will help
			if diary_panel_container_children_name == "DiaryPanel":
				diary_panel_container_children[0].queue_free()
			else:
				print("Error! DiaryPanelContainer store not DiaryPanel node but" + diary_panel_container_children_name)
		else:
			$DiaryPanelContainer.add_child(diary_panel.instance())
	print($DiaryPanelContainer.get_children())