extends MeshInstance

const bricks = preload("res://scenes/entities/UnpushableBlockMaterial2.tres")

func change_material():
	print("it's triggering in Unpush Block.gd")
	set_surface_material(0, bricks)