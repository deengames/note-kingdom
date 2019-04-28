extends Node

const VolumeHelper = preload("res://scripts/VolumeHelper.gd")

func _ready():
	var children = get_children()
	for child in children:
		if child is AudioStreamPlayer:
			child.volume_db = VolumeHelper.get_volume(Globals.music_volume)
	
	$Channel1.play()