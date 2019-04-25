extends Node

const Player = preload("res://scenes/entities/Player.gd")

var player: Player

var _DEFAULT_FONT = preload("res://assets/fonts/DefaultFont.tres")
var _language: String = "en-US"

var last_room: String = "" # we need this for moving the player appropriately on loading rooms
var current_room: String = "" # we need this for saves

var notes_collected: Array = [] # Please leave notes_collected empty. We append the keys to this array as you collect notes [[false, "first_note"], [false, "second_note"], [false, ""], [false, ""], [false, ""]] # as you get note, set notes_collected[note_numer][0] = true

# Set of supported languages. Key is language code; value
# is a hash of message_key => localized message
var _language_data = {"en-US": {}, "ru-RU": {}, "hi-HI": {}}

var _language_fonts = {
	"hi-HI": preload("res://assets/fonts/HindiFont.tres")
}

func _ready():
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
		return data[message_key]
	else:
		print("WARNING: No message with key={k} in {l} language".format({k = message_key, l = _language}))
		 # make it obvious that it's missing
		return message_key.to_upper()