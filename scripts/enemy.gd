extends Node2D

var direction = 1

var movement_enabled = true

@onready var ray_cast_right: RayCast2D = $RayCastRight

@onready var ray_cast_left: RayCast2D = $RayCastLeft

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var kirby: CharacterBody2D = get_node("/root/Game/Kirby")

var knockedback = false
var knockDirection = 0
var knockback_force = 300
func _ready():
	add_to_group("waddle_doo")
func _process(delta: float) -> void:
	if knockedback == true:
		position.x += knockback_force * knockDirection * delta
	if movement_enabled == true:
		if ray_cast_right.is_colliding():
			var collider = ray_cast_right.get_collider()
			direction = -1
			animated_sprite_2d.flip_h = true
		if ray_cast_left.is_colliding():
			var collider = ray_cast_left.get_collider()
			direction = 1
			animated_sprite_2d.flip_h = false
		if movement_enabled == false:
			position.x = 0
		else:
			position.x += direction * 60 * delta
