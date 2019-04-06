extends KinematicBody

# Y-component is zero so we stay flat on the ground
export var move_speed:float = 10.0 # pixels per second?
export var block_push_delay:float = 0.2 # in seconds, how long before the block pushes on contact
var _acceleration:Vector3 = Vector3(0, 0, 0)
var can_move = true
var _push_delay = 0.0 
var _last_input:Vector2 = Vector2(0, 0) 
const RAYCAST_DISTANCE = 1.25
const STEP_DISTANCE = 4.0

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
#			$RayCastFar.cast_to = $RayCast.cast_to * 4
		var collider = $RayCast.get_collider()
		
		if collider != null:
#			$RayCastFar.enabled = true
#			$RayCastFar.add_exception(collider)
			var behind_collider = $RayCastFar.get_collider()
			_push_delay += delta
			 # added a delay instead of a button press
			if collider is KinematicBody and "pushable" in collider and collider.pushable and behind_collider == null and _push_delay >= block_push_delay and _last_input == input_direction:
				move_and_slide($RayCast.cast_to.normalized() * STEP_DISTANCE)
				collider.move_and_slide($RayCast.cast_to.normalized() * STEP_DISTANCE)
			$PlayerCharacter/AnimationPlayer.play("Push")
			$PlayerCharacter.rotation.y = Vector2(-$RayCast.cast_to.x, $RayCast.cast_to.z).tangent().angle()
		else:
#			$RayCastFar.enabled = false
#			$Tween.reset_all()
			_push_delay = 0.0
			move_and_slide(_acceleration)
			$PlayerCharacter/AnimationPlayer.play("Run")
			$PlayerCharacter.rotation.y = -input_direction.tangent().angle()
					
		_last_input = input_direction

func _on_Tween_tween_completed(object, key):
	if object == self:
#		$RayCastFar.clear_exceptions()
		can_move = true