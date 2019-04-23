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
	emit_signal("enter_or_exit")
	# what I was thinking for level transitions kind of breaks puzzles, so let's just change rooms and
	# keep info we need in global or something
	if newArea != "":
		if get_tree().get_root().get_node("Location").location_name: # note the space between the words in location_name
			old_area = get_tree().get_root().get_node("Location").location_name
			print("old area name is " + old_area)
		get_tree().change_scene(newArea)
	else:
		old_area = get_tree().current_scene.name
		var nameString = ""
		if old_area.begins_with("Block"):
			nameString = "South"
		elif old_area.begins_with("Switch"):
			nameString = "East"
		elif old_area.begins_with("Plate"):
			nameString = "West"
		elif old_area.begins_with("Key"):
			nameString = "North"
		if nameString != "":
			get_tree().change_scene("res://scenes/WorldAreas/Village" + nameString + ".tscn")
	# at the end here, move player to the spot if it's got one
	# jk, store it in global and dump in player ready lolololol
	$"/root/Globals".last_room = old_area
	
# this is garbage, how to wait for new scene to load first--maybe I can't, because the new scene is waiting on
# this script to finish deleting itself maybe?
#	if old_area != "":
#		yield(get_tree().current_scene, "tree_exited")
##		yield(get_tree().current_scene, "tree_entered")
#		yield(get_tree().current_scene, "ready")
#		print("current is ready")
#		var base = get_tree().get_root().get_child(1) # this seems hacky
#		var pos_3D = base.find_node(old_area, true, false)
#		if pos_3D:
#			print("pos 3d is " + pos_3D.name)
#			base.get_node("KinematicBody").global_transform.translation = pos_3D.global_transform.translation
##			get_tree().call_group("player", "set", ["translation", pos_3D.translation])