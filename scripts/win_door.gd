extends Game_Object

@onready var kirby: CharacterBody2D = get_node("/root/Game/Kirby")

func on_collision(body:Node2D):
	if body == kirby:
		get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
	pass
