extends Node

@onready var enums: Node = %Enums
@onready var WADDLE_DOO = preload("res://scenes/enemy.tscn")
const WADDLE_DEE = preload("res://scenes/waddle_dee.tscn")
@onready var game = $".."


func create_enemy(enemy_type):
	if enemy_type == enums.EnemyType.waddledoo:
		return WADDLE_DOO.instantiate()
	elif enemy_type == enums.EnemyType.waddledee:
		return WADDLE_DEE.instantiate()
