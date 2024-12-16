extends Node

@onready var enums: Node = %Enums
@onready var EnemyScene = preload("res://scenes/enemy.tscn")
@onready var game = $".."


func create_enemy(enemy_type):
	if enemy_type == enums.EnemyType.waddledoo:
		return EnemyScene.instantiate()
	elif enemy_type == enums.EnemyType.waddledee:
		return EnemyScene.instantiate()
