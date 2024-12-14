extends Area2D


@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var save_game: Node2D = get_node("/root/Game/SaveGame")

func _on_body_entered(body: Node2D) -> void:
	save_game.save_game()
	animated_sprite_2d.play("open")
	collision_shape_2d.disabled = true


func _on_animated_sprite_2d_animation_finished() -> void:
	animated_sprite_2d.stop()
	animated_sprite_2d.frame = 4
