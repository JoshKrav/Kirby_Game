extends Node

signal HealthChanged

var health = 100
var maxHealth = 100
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

var score = 0
func _ready() -> void:
	var audio_stream = audio_stream_player_2d.stream
	if audio_stream is AudioStream:
		audio_stream.loop = true
	audio_stream_player_2d.play()
func take_damage():
	if (health - 20 <= 0 ):
		game_over()
	else:
		health -= 20
	HealthChanged.emit()
func game_over():
	health=5
	
