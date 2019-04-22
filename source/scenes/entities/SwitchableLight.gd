extends Spatial

export var is_on:bool = false

func _ready():
	_update_energy()

func flip():
	is_on = not is_on
	_update_energy()

func _update_energy():
	if is_on:
		$OmniLight.light_energy = 1
	else:
		$OmniLight.light_energy = 0