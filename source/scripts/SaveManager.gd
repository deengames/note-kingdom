extends Node

# Obfuscation by compression
const _SAVE_COMPRESSION_MODE = File.COMPRESSION_DEFLATE  
const SAVE_FILE_NAME = "user://NoteKingdomSave.dat"
const PREFERENCES_FILE_NAME = "user://NoteKingdomPreferences.dat"

static func save(file_name, data):
	var serialized_data = to_json(data)
	var save_game = File.new()
	save_game.open_compressed(file_name, File.WRITE, _SAVE_COMPRESSION_MODE)	
	save_game.store_line(serialized_data)
	save_game.close()

static func load(file_name):
	var save_game = File.new()
	
	if not save_game.file_exists(file_name):
		return # Error! We don't have a save to load.
	
	save_game.open_compressed(file_name, File.READ, _SAVE_COMPRESSION_MODE)
	
	var data = parse_json(save_game.get_line())
	save_game.close()
	return data