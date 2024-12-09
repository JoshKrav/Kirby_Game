extends Area2D

@onready var kirby: CharacterBody2D = $".."

@onready var animated_sprite: AnimatedSprite2D = $"../AnimatedSprite2D"


@onready var timer: Timer = $Timer


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		kirby.swallowed_entity = area.get_parent().get_groups()
		area.get_parent().queue_free()
		area.queue_free()
		kirby.swallowed = true
		timer.start(.75)
		animated_sprite.stop()
		animated_sprite.play("unsuck")

func _on_timer_timeout() -> void:
	kirby.isSucking = false
	kirby.swallowed=true
	kirby.suck_collision.disabled = true
	animated_sprite.play("swallowed_idle")
