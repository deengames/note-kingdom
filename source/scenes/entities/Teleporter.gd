extends Spatial

export var target_name:String = ""
export var one_time_use:bool = false

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
	$AudioStreamPlayer.play()
	
	if can_teleport:
		body.translation = Vector3(_target.translation.x, _target.translation.y + 10, _target.translation.z)
		if self.one_time_use:
			self.get_parent().remove_child(self)
			yield($AudioStreamPlayer, "finished")
			self.queue_free()

func _on_Area_body_exited(body):
	can_teleport = true
