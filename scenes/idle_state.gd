extends State
class_name IdleState
var SPEED = 100.0


@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

@onready var kirby: Kirby = $"../.."


func Update(delta):
	if Input.is_action_just_pressed("suck"):
		Transitioned.emit(self,"inhalestate")
	if Input.is_action_just_pressed("jump") and kirby.is_on_floor():
		Transitioned.emit(self,"jumpingstate")
	kirby.direction = Input.get_axis("move_left", "move_right")
	if kirby.direction:
		Transitioned.emit(self,"walkingstate")
func Enter():
	animated_sprite_2d.play("idle")
	kirby.velocity.x=0.0
func Exit():
	pass
