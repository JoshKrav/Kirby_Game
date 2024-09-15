extends Area2D

@onready var kirby: CharacterBody2D = get_node("/root/Game/Kirby")

@onready var game_manager: Node = get_node("/root/Game/GameManager")

@onready var animated_sprite: AnimatedSprite2D = get_node("/root/Game/Kirby/AnimatedSprite2D")

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

@onready var timer: Timer = $"../Timer"

@onready var death_timer: Timer = $DeathTimer

@onready var waddle_doo: Node2D = $".."

var movement_enabled = true

func _on_body_entered(body: Node2D) -> void:
	if body == kirby:
		kirby.hurt = true
		kirby.velocity.x = -1000
		kirby.velocity.y = -200
		animated_sprite_2d.play("hurt")
		get_parent().movement_enabled = false
		timer.start()
		
func _take_damage():
	death_timer.start(.7)
	animated_sprite_2d.play("hurt")
	get_parent().movement_enabled = false

func _ready() -> void:
	add_to_group("enemies")

func _on_timer_timeout() -> void:
	get_parent().movement_enabled = true
	animated_sprite_2d.play("walk")
	kirby.hurt = false

func _on_death_timer_timeout() -> void:
	get_parent().queue_free()
	queue_free()
