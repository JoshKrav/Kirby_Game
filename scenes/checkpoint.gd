extends Area2D

@onready var resource_preloader: ResourcePreloader = $ResourcePreloader
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

func _on_body_entered(body: Node2D) -> void:
	resource_preloader.save()
	animated_sprite_2d.play("open")
	pass # Replace with function body.
