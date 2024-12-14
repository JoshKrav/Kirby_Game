extends State
class_name InhaledIdleState

@onready var kirby: Kirby = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func Update(delta):
	if Input.is_action_just_pressed("suck"):
		Transitioned.emit(self,"shootstarstate")
	if Input.is_action_just_pressed("jump") and kirby.is_on_floor():
		Transitioned.emit(self,"inhaledjumpingstate")
	kirby.direction = Input.get_axis("move_left", "move_right")
	if kirby.direction:
		Transitioned.emit(self,"inhaledwalkingstate")
func Enter():
	animated_sprite_2d.play("swallowed_idle")
func Exit():
	pass
