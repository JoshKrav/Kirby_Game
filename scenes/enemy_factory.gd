extends Node

@onready var EnemyScene = preload("res://scenes/enemy.tscn")
@onready var game = $".."
func create_enemy(enemy):
	var new_enemy = EnemyScene.instantiate()
	new_enemy.spawnPos = enemy.global_position
	game.add_child.call_deferred(new_enemy)
