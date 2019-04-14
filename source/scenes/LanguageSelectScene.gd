extends Node2D

func _on_EnglishButton_pressed():
	Globals.set_language("en-US")
	_launch_game()

func _on_RussianButton_pressed():
	Globals.set_language("ru-RU")
	_launch_game()
	
func _launch_game():
	get_tree().change_scene("res://scenes/WalkingTraversal.tscn")
