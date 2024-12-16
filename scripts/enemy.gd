extends Node2D

var direction = 1

var movement_enabled = true

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var collision_shape_2d: CollisionShape2D = $EnemyHit/CollisionShape2D
@onready var enemy_hit: Area2D = $EnemyHit

@onready var ray_cast_left: RayCast2D = $RayCastLeft

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var kirby: CharacterBody2D = get_node("/root/Game/Kirby")

@export var shrink_duration: float = 1.0
@export var rotation_speed: float = 360.0 # Total rotation in degrees
@export var target_scale: Vector2 = Vector2(0.1, 0.1) # Target scale
@export var move_duration: float = 1.0

var knockedback = false
var knockDirection = 0
var knockback_force = 300
func _ready():
	if self.name == "WaddleDoo":
		add_to_group("waddle_doo")
	elif self.name == "WaddleDee":
		add_to_group("waddle_dee")
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

func shrink_and_spin():
	enemy_hit.set_deferred("monitoring",false)
	collision_shape_2d.disabled = true
	var tween = create_tween()
	var tween2 = create_tween()
	var tween3= create_tween()
	animated_sprite_2d.play("hurt")
	tween.tween_property(
		self,"global_position",kirby.global_position,move_duration
	)
	tween2.tween_property(
		self,"rotation_degrees",rotation_degrees + rotation_speed,shrink_duration)
	tween3.tween_property(
		self,"scale",target_scale,shrink_duration
		)
	tween3.finished.connect(on_tween_finished)

func on_tween_finished():
	self.queue_free()
