extends KinematicBody

# Y-component is zero so we stay flat on the ground
export var move_speed:int = 200 # pixels per second?
var _acceleration:Vector3 = Vector3(0, 0, 0)
var can_move = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move:
		if Input.is_key_pressed(KEY_S):
			self._acceleration.z = move_speed
			$RayCast.cast_to = Vector3(0, 0, 1.25)
		elif Input.is_key_pressed(KEY_W):
			self._acceleration.z = -move_speed
			$RayCast.cast_to = Vector3(0, 0, -1.25)
		else:
			self._acceleration.z = 0
		
		if Input.is_key_pressed(KEY_D):
			$RayCast.cast_to = Vector3(1.25, 0, 0)
			self._acceleration.x = move_speed
		elif Input.is_key_pressed(KEY_A):
			self._acceleration.x = -move_speed
			$RayCast.cast_to = Vector3(-1.25, 0, 0)
		else:
			self._acceleration.x = 0
		
		if Input.is_key_pressed(KEY_E):
			var collider = $RayCast.get_collider()
			if collider != null:
				if collider.pushable:
					$Tween.reset_all()
					$Tween.interpolate_property(collider, "translation", collider.translation, collider.translation + $RayCast.cast_to * 2, 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
					$Tween.interpolate_property(self, "translation", self.translation, self.translation + $RayCast.cast_to * 2, 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
					$Tween.start()
					can_move = false
	
	_acceleration = move_and_slide(self._acceleration * delta)

func _on_Tween_tween_completed(object, key):
	if object == self:
		can_move = true