extends Spatial

signal enter_or_exit

# If this loads a scene that has the current scene in it, it does circular loading and crashes
#export(PackedScene) var newArea


export(String, FILE, "*.tscn") var newArea: = ""# let's just use the string resource location instead
export(int) var unlockNumber: = 0 # the number of notes needed to unlock this puzzle.

func _ready():
	if Globals.notes_collected.size() == unlockNumber and has_node("AnimationPlayer"):
		$AnimationPlayer.play("Open")
	elif Globals.notes_collected.size() > unlockNumber and has_node("AnimationPlayer"):
		$AnimationPlayer.play("Open")
		$AnimationPlayer.seek($AnimationPlayer.current_animation_length, true)

#warning-ignore:unused_argument
func enter_or_exit_puzzle(body=null): # this sometimes takes 1 arg that we discard, so just leave this
	var old_area = ""
	emit_signal("enter_or_exit", body)
	# what I was thinking for level transitions kind of breaks puzzles, so let's just change rooms and
	# keep info we need in global or something
	if body.has_node("GUI"): # this fades to white and back
		body.get_node("GUI/AnimationPlayer").play_backwards("ScreenFade")
		body.get_node("PlayerCharacter/AnimationPlayer").stop(false)
		body.set_physics_process(false)
		yield(body.get_node("GUI/AnimationPlayer"), "animation_finished")
	else:
		print("where is GUI though?")
	
	if newArea != "":
		if get_tree().get_root().get_node("Location").location_name: # note the space between the words in location_name
			old_area = get_tree().get_root().get_node("Location").location_name
			print("old area name is " + old_area)
			print("new area name is " + newArea)
		
		get_tree().change_scene(newArea)
	else:
		old_area = get_tree().current_scene.name
		var nameString = ""
		if old_area.begins_with("Block"):
			nameString = "VillageSouth"
		elif old_area.begins_with("Switch"):
			nameString = "VillageWest"
		elif old_area.begins_with("Plate"):
			nameString = "VillageEast"
		elif old_area.begins_with("Key"):
			nameString = "VillageNorth"
		elif old_area.begins_with("Teleporter"):
			nameString = "Castle"
		if nameString != "":
			get_tree().change_scene("res://scenes/WorldAreas/" + nameString + ".tscn")
	# at the end here, move player to the spot if it's got one
	# jk, store it in global and dump in player ready lolololol
	$"/root/Globals".last_room = old_area