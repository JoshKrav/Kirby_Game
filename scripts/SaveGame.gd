extends ResourcePreloader

var kirby = preload("res://scripts/character_body_2d.gd")
var game_manager= preload("res://scripts/game_manager.gd")

var save_filename = "user://savegame.tres"

func save_game():
	ResourceSaver.save(save_filename,"res://scripts/SaveGame.gd")
func load_data():
	if ResourceLoader.exists(save_filename):
		return load(save_filename)
	return null
