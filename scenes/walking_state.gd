extends State
class_name WalkingState
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var kirby: CharacterBody2D = $"../.."
var SPEED = 100.0
@onready var suck: Area2D = $"../../Suck"

func Enter():
	animated_sprite_2d.play("walk")
func Update(delta):
	if kirby.direction > 0:
		animated_sprite_2d.flip_h = false
		suck.scale.x = 1
	elif kirby.direction < 0:
		animated_sprite_2d.flip_h = true
		suck.scale.x = -1
func Physics_Update(delta):
	kirby.direction = Input.get_axis("move_left", "move_right")
	if Input.is_action_just_pressed("jump") and kirby.is_on_floor():
		Transitioned.emit(self,"jumpingstate")
	if Input.is_action_just_pressed("run"):
		Transitioned.emit(self,"runningstate")
	if kirby.direction:
		kirby.velocity.x = kirby.direction * SPEED
	else:
		kirby.velocity.x = move_toward(kirby.velocity.x, 0, SPEED)
		Transitioned.emit(self,"idlestate")
func Exit():
	animated_sprite_2d.play("idle")
