extends Area2D

@onready var timer: Timer = $Timer
@onready var save_game: Node2D = get_node("/root/Game/SaveGame")

func _on_body_entered(body: Node2D) -> void:
	timer.start(0.6)


func _on_timer_timeout() -> void:
	if save_game.load_data() == false:
		get_tree().reload_current_scene()
