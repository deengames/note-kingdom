extends Button

var note_key
var NotePanel = preload("res://scenes/NotePanel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	var note_panel = NotePanel.instance()
	note_panel.set_text(note_key)
	# Chain of code to add new NotePanel into GUI
	var note_panel_container_children = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("NotePanelContainer").get_children()
	# NoteContainer should be used only to store one NotePanel at once 
	# If NoteContainer already store something
	if note_panel_container_children != []:
		note_panel_container_children[0].queue_free()
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("NotePanelContainer").add_child(note_panel)