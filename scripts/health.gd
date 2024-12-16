extends Game_Object

@onready var kirby: CharacterBody2D = get_node("/root/Game/Kirby")

@onready var game_manager: Node = get_node("/root/Game/GameManager")

func on_collision(body:Node2D):
	if kirby == body:
		game_manager.heal()
		self.queue_free()
