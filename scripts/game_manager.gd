extends Node

signal HealthChanged

var health = 100
var maxHealth = 100
var lives = 3
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var game: Node2D = $".."
@onready var EnemyScene = preload("res://scenes/enemy.tscn")
@onready var enums: Node = $"../Enums"
@onready var enemy_factory: Node = $"../EnemyFactory"
@onready var save_game: Node2D = $"../SaveGame"

var score = 0
func _ready() -> void:
	var audio_stream = audio_stream_player_2d.stream
	if audio_stream is AudioStream:
		audio_stream.loop = true
	audio_stream_player_2d.play()
	var new_enemy = enemy_factory.create_enemy(enums.EnemyType.waddledoo)
	add_enemy_to_scene(new_enemy,Vector2(719,-83))
	new_enemy = enemy_factory.create_enemy(enums.EnemyType.waddledoo)
	add_enemy_to_scene(new_enemy,Vector2(1078,12))
	new_enemy = enemy_factory.create_enemy(enums.EnemyType.waddledee)
	add_enemy_to_scene(new_enemy,Vector2(338,12))
	new_enemy = enemy_factory.create_enemy(enums.EnemyType.waddledee)
	add_enemy_to_scene(new_enemy,Vector2(1090,12))
	new_enemy = enemy_factory.create_enemy(enums.EnemyType.waddledoo)
	add_enemy_to_scene(new_enemy,Vector2(1110,12))

func add_enemy_to_scene(new_enemy,position):
	new_enemy.global_position = position
	game.add_child.call_deferred(new_enemy)
func take_damage():
	if (health - 20 <= 0 ):
		game_over()
	else:
		health -= 20
	HealthChanged.emit()
func game_over():
	if lives > 0:
		score-=100
		lives-=1
		health = 100
		HealthChanged.emit()
		save_game.load_data()
	else:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
func heal():
	if health+20 <= 100:
		health+=20
		HealthChanged.emit()
