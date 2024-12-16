extends Control

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var save_data: Node2D = $SaveData

func _ready() -> void:
	audio_stream_player_2d.play()
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_new_game_pressed() -> void:
	save_data.overwrite()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	pass # Replace with function body.
