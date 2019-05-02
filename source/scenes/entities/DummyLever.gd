extends Spatial

# Exactly like the lever code, but disregards first in the list of children to trick players

const Player = preload("res://scenes/entities/Player.gd")
const SwitchableBlock = preload("res://scenes/entities/SwitchableBlock.gd")
#const VolumeHelper = preload("res://scripts/VolumeHelper.gd")

var _OFF_ROTATION
var _is_on = false
var _is_player_touching = false

func _ready():
	_OFF_ROTATION = $Handle.rotation_degrees

func flip():
	$AudioStreamPlayer.play()
	self._is_on = not self._is_on
	if self._is_on:
		$Handle.rotation_degrees = -_OFF_ROTATION
	else:
		$Handle.rotation_degrees = _OFF_ROTATION

	self._move_my_blocks()

func _on_Area_body_entered(body):
	if body is Player:
		_is_player_touching = true

func _on_Area_body_exited(body):
	if body is Player:
		_is_player_touching = false

func _input(event):
    if "pressed" in event and not event.pressed and \
	_is_player_touching and event is InputEventKey and event.scancode == KEY_SPACE:
        self.flip()

# Flips all the blocks in the same group in the parent as us.
# Clever code. Find our parent, which is a group (eg. Node).
# Find all the switchable blocks in it. Flip 'em.
# TODO: should be more explicit way of doing this.
func _move_my_blocks():
	var parent_group = self.get_parent()
	var siblings = parent_group.get_children()

	for sibling in siblings:
		if sibling.get_position_in_parent() != 0: # This is the trick
			if sibling is SwitchableBlock:
				sibling.flip()
