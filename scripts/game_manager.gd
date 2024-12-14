extends Node

var health = 5

var score = 0

func take_damage():
	if (health - 1 == 0 ):
		game_over()
	else:
		health -= 1
func game_over():
	health=5
	
