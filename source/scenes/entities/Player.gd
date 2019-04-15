extends KinematicBody

# Y-component is zero so we stay flat on the ground
export var player_speed:float = 10.0 # pixels per second?
export var block_push_delay:float = 0.2 # in seconds, how long before the block pushes on contact

var can_move = true

var _acceleration:Vector3 = Vector3(0, 0, 0)
var _push_delay = 0.0 
var _last_input:Vector2 = Vector2(0, 0) 

const RAYCAST_DISTANCE = 1.25
const STEP_DISTANCE = 4.0
const _GRAVITY = -10 # downward force
var RUN_SPEED = player_speed * 2
var WALK_SPEED = player_speed
const MAX_SLOPE_ANGLE = 60

# TODO: persist when you recreate the character
var keys = [] # numbers like 1, 37

func _physics_process(delta):
	_process_input(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process_input(delta):
	
	if can_move:
		# Run option
		var move_speed
		
		if Input.is_action_pressed("run"):
			move_speed = RUN_SPEED
		else:
			move_speed = WALK_SPEED
		
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
			
		
		_acceleration = Vector3(input_direction.x, _GRAVITY, input_direction.y) * move_speed
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
			# Values from: https://docs.godotengine.org/en/3.1/tutorials/3d/fps_tutorial/part_one.html?highlight=gravity
			move_and_slide(_acceleration, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))
			$PlayerCharacter/AnimationPlayer.play("Run")
			$PlayerCharacter.rotation.y = -input_direction.tangent().angle()
					
		_last_input = input_direction