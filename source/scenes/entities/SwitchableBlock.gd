extends StaticBody

#export var appear:bool = true

func _ready():
	# set visibility/state based on external property
	# self.visible = self.appear
	self.visible = self.name.to_lower().begins_with("on")
	self._update_state()

func flip():
	self.visible = not self.visible
	self._update_state()

func _update_state():
	$CollisionShape.disabled = not self.visible