extends Spatial

const Player = preload("res://scenes/entities/Player.gd")

var _OFF_ROTATION
var _is_on = false
var _is_player_touching = false

func _ready():
	_OFF_ROTATION = $Handle.rotation_degrees

func flip():
	self._is_on = not self._is_on
	if self._is_on:
		$Handle.rotation_degrees = -_OFF_ROTATION
	else:
		$Handle.rotation_degrees = _OFF_ROTATION

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