extends Area2D

@onready var enemy_hit: Area2D = $"."

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		area._take_damage()
		get_parent().queue_free()
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	get_parent().queue_free()
	queue_free()
