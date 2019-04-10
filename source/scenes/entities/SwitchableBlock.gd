extends StaticBody

export var appear:bool = true

func _ready():
	# set visibility/state based on property
	self.visible = self.appear
	self._update_state()

func flip():
	self.visible = not self.visible
	self._update_state()

func _update_state():
	$CollisionShape.disabled = not self.visible