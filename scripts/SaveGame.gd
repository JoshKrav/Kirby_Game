extends Node2D

@onready var kirby: CharacterBody2D = get_node("/root/Game/Kirby")


var save_filename = "user://savegame.tres"
var config = ConfigFile.new()
func save_game():
	config.set_value("kirby","global_position",kirby.global_position)
	config.save(save_filename)
func load_data():
	var err = config.load(save_filename)
	if err == OK:
		kirby.global_position = config.get_value("kirby","global_position")
		return true
	return false
