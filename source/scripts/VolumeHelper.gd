extends Node

# Map all sounds from 0dB (uses the wave-form data) to, -80
# (if this value is 80). To use global volume, we just map 
# things to the range [-80 ... 0] and that's [0..100] volume.
const _DECIBAL_RANGE = 80

# global_volume is either Global.music_volume or Global.sfx_volume
static func get_volume(global_volume):
	return -_DECIBAL_RANGE + (_DECIBAL_RANGE * global_volume / 100)