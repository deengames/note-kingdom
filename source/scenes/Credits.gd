extends Node2D

func _ready():
	$Label.add_font_override("font", Globals.get_language_font())
	$Label.text = Globals.translate("CREDITS_TEXT").replace("@names", "Nightblade, mrdudeiii, legendiguess, Bhagat")
	
	$Button.add_font_override("font", Globals.get_language_font())
	$Button.text = Globals.translate("BACK_TO_MAIN")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")