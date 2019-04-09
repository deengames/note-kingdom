extends StaticBody

const _HIDDEN_Y = -4
var _base_y = self.translation.y

func flip():
	# TODO: tween
	self.translation.y = _HIDDEN_Y - self.translation.y
	print(str(self.translation.y))