extends Spatial

export var target_name:String = ""
var can_teleport = true
var _target

func _ready():
	var parent = self.get_parent()
	var siblings = parent.get_children()
	for sibling in siblings:
		if sibling.name == target_name:
			_target = sibling
			break
			
	if _target == null:
		print("WARNING: can't find teleporter target " + target_name)

func _on_Area_body_entered(body):
	if can_teleport:# and body == Globals.player:
		_target.can_teleport = false
		body.translation = Vector3(_target.translation.x, _target.translation.y + 10, _target.translation.z)
		print("Teleported to " + target_name)

func _on_Area_body_exited(body):
	#if body == Globals.player:
	can_teleport = true
