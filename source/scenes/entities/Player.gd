extends KinematicBody

# Y-component is zero so we stay flat on the ground
export var move_speed:int = 200 # pixels per second?
export var block_push_delay:float = 0.2 # in seconds, how long before the block pushes on contact
var _acceleration:Vector3 = Vector3(0, 0, 0)
var can_move = true
var _push_delay = 0.0 
var _last_input:Vector2 = Vector2(0, 0) 
const RAYCAST_DISTANCE = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move:
		# MrDudeIII found this in a KidsCanCode tutorial
		var input_direction = Vector2(
			int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
			int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
			)
		if not input_direction:
			_push_delay = 0.0 # reset the push delay if you stop pressing a button
			$PlayerCharacter/AnimationPlayer.play("Stand")
			return
		else:
			input_direction = input_direction.normalized()
			
		
		_acceleration = Vector3(input_direction.x, 0, input_direction.y) * move_speed
		if abs(input_direction.x) == 1.0 or abs(input_direction.y) == 1.0:
			$RayCast.cast_to = Vector3(input_direction.x, 0, input_direction.y) * RAYCAST_DISTANCE
			$RayCastFar.cast_to = $RayCast.cast_to * 4
		var collider = $RayCast.get_collider()
		
		if collider != null:
			$RayCastFar.enabled = true
			$RayCastFar.add_exception(collider)
			var behind_collider = $RayCastFar.get_collider()
			_push_delay += delta
			if collider.pushable and behind_collider == null and _push_delay >= block_push_delay and _last_input == input_direction: # added a delay instead of a button press
#				$Tween.reset_all()
				$Tween.interpolate_property(collider, "translation", collider.translation, collider.translation + $RayCast.cast_to * 2, 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				$Tween.interpolate_property(self, "translation", self.translation, self.translation + $RayCast.cast_to * 2, 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				$Tween.start()
				can_move = false
			$PlayerCharacter/AnimationPlayer.play("Push")
			$PlayerCharacter.rotation.y = Vector2(-$RayCast.cast_to.x, $RayCast.cast_to.z).tangent().angle()
			
		else:
			$RayCastFar.remove_exception(collider)
			$RayCastFar.enabled = false
			$Tween.reset_all()
			_push_delay = 0.0
			_acceleration = move_and_slide(self._acceleration * delta)
			$PlayerCharacter/AnimationPlayer.play("Run")
			$PlayerCharacter.rotation.y = -input_direction.tangent().angle()
					
		_last_input = input_direction

func _on_Tween_tween_completed(object, key):
	if object == self:
		can_move = true