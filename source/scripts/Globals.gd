extends Node

const Player = preload("res://scenes/entities/Player.gd")
const SaveManager = preload("res://scripts/SaveManager.gd")

var player: Player

var _DEFAULT_FONT = preload("res://assets/fonts/DefaultFont.tres")


# START: global settings to save
var _language: String = "en-US"
# ranges from -40 (fully muted) to 0 (full volume)
var music_volume:float = -20
var sfx_volume:float = -20
# END: global settings to save


# START: save per save-game
var last_room: String = "" # we need this for moving the player appropriately on loading rooms
var current_room: String = "" # we need this for saves

var notes_collected: Array = [] # as you get any note array fill up by notes_collected.append(Note key)
# END: save per save-game


# Set of supported languages. Key is language code; value
# is a hash of message_key => localized message
var _language_data = {"en-US": {}, "ru-RU": {}, "hi-HI": {}}

var _language_fonts = {
	"hi-HI": preload("res://assets/fonts/HindiFont.tres")
}

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), Globals.sfx_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), Globals.music_volume)
	self._load_global_preferences()
	
	for code in _language_data.keys():
		var file = File.new()
		file.open("res://assets/text/{code}.txt".format({code = code}), File.READ)
		
		while not file.eof_reached():
			var line = file.get_line()
			# MESSAGE_KEY: message value here
			var delimiter = line.find(":")
			var key = line.substr(0, delimiter)
			var message = line.substr(delimiter + 2, len(line))
			
			_language_data[code][key] = message
		file.close()

func set_language(code):
	self._language = code

func get_language_font():
	if _language_fonts.has(_language):
		return _language_fonts[_language]
	else:
		return _DEFAULT_FONT

func translate(message_key):
	var data = _language_data[_language]
	if data.has(message_key):
		return data[message_key].c_unescape()
	else:
		print("WARNING: No message with key={k} in {l} language".format({k = message_key, l = _language}))
		 # make it obvious that it's missing
		return message_key.to_upper()
		
func _load_global_preferences():
	var manager = SaveManager.new()
	var data = manager.load(manager.PREFERENCES_FILE_NAME)
	if data != null:
		set_language(data["language"])
		
		if "music_volume" in data:
			music_volume = data["music_volume"]
			
		if "sfx_volume" in data:
			sfx_volume = data["sfx_volume"]