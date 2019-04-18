extends Node

const Player = preload("res://scenes/entities/Player.gd")

var player:Player
var _language:String = "en-US"
# Set of supported languages. Key is language code; value
# is a hash of message_key => localized message
var _language_data = {"en-US": {}, "ru-RU": {}}

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

func translate(message_key):
	var data = _language_data[_language]
	if data.has(message_key):
		return data[message_key]
	else:
		print("WARNING: No message with key={k} in {l} language".format({k = message_key, l = _language}))
		 # make it obvious that it's missing
		return message_key.to_upper()