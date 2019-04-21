extends Spatial

signal enter_or_exit

# If this loads a scene that has the current scene in it, it does circular loading and crashes
#export(PackedScene) var newArea

export(String, FILE, "*.tscn") var newArea: = ""# let's just use the string resource location instead

func enter_or_exit_puzzle(body=null): # this sometimes takes 1 arg that we discard, so just leave this
	emit_signal("enter_or_exit")
	# what I was thinking for level transitions kind of breaks puzzles, so let's just change rooms and
	# keep info we need in global or something
	if newArea != "":
		get_tree().change_scene(newArea)
	else:
		if get_tree().current_scene.name.begins_with("Block"):
			# we can probably keep the area in memory instead of unloading it?
			get_tree().change_scene("res://scenes/WorldAreas/VillageSouth.tscn")
		elif get_tree().current_scene.name.begins_with("Switch"):
			get_tree().change_scene("res://scenes/WorldAreas/VillageEast.tscn")
		elif get_tree().current_scene.name.begins_with("Plate"):
			get_tree().change_scene("res://scenes/WorldAreas/VillageWest.tscn")
		elif get_tree().current_scene.name.begins_with("Key"):
			get_tree().change_scene("res://scenes/WorldAreas/VillageNorth.tscn")
