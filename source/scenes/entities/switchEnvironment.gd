extends WorldEnvironment

const castleEnv = preload("res://scenes/WorldAreas/DarkEnv.tres")
# this is a bit hacky lol

# actually, it's super hacky

func change_material(): # yes yes yes I know this is not helpful. it's faster though.
	environment = castleEnv
