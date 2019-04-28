extends Spatial

const VolumeHelper = preload("res://scripts/VolumeHelper.gd")

func _ready():
	$RunningSteps.volume_db = VolumeHelper.get_volume(Globals.sfx_volume)
	$PushingSteps.volume_db = VolumeHelper.get_volume(Globals.sfx_volume)