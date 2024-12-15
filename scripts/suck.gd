extends Area2D

@onready var kirby: CharacterBody2D = $".."

@onready var animated_sprite: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var game_manager: Node = %GameManager


@onready var timer: Timer = $Timer

@onready var state_machine: Node = $"../StateMachine"

@onready var inhale_state: InhaleState = $"../StateMachine/InhaleState"


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		game_manager.score+=250
		var enemy = area.get_parent()
		kirby.swallowed_entity = enemy.get_groups()
		enemy.shrink_and_spin()
		kirby.swallowed = true
		timer.start(.75)
		animated_sprite.stop()
		animated_sprite.play("unsuck")

func _on_timer_timeout() -> void:
	kirby.isSucking = false
	kirby.swallowed=true
	kirby.suck_collision.disabled = true
	state_machine.on_child_transition(inhale_state,"inhaledidlestate")
