extends Node

const VolumeHelper = preload("res://scripts/VolumeHelper.gd")

func _ready():
	var children = get_children()
	for child in children:
		if child is AudioStreamPlayer:
			child.volume_db = VolumeHelper.get_volume(Globals.music_volume)
	
	$Channel1.play()

func change_track(area):
#	$Tween.interpolate_property($Channel1, "volume_db", -10, -80, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	$Tween.interpolate_property($Channel2, "volume_db", -10, -80, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	$Tween.start()
#	yield($Tween, "tween_completed")
	print("in music, area is " + area)
	match area:
		"Castle":
			$Channel1.stream = load("res://music/CastleKeep.ogg")
#			$Channel2.play()
			$Channel1.play()
		"Sanctum":
			$Channel1.stop()
#			$Channel2.stop()
		_:
			$Channel1.stream = load("res://music/WalkingInVillage.ogg")
			$Channel1.play()
#			$Channel2.stop()
#	$Tween.reset_all()
#	$Tween.interpolate_property($Channel1, "volume_db", -80, -10, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	$Tween.interpolate_property($Channel2, "volume_db", -80, -10, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	$Tween.start()
#	yield($Tween, "tween_completed")