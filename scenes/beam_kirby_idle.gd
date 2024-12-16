extends State
class_name BeamKirbyIdle

@onready var kirby: Kirby = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var beam_kirby: AnimatedSprite2D = $"../../BeamKirby"

func Update(delta):
	if Input.is_action_just_pressed("suck"):
		Transitioned.emit(self,"beamkirbyattackstate")
	if Input.is_action_just_pressed("jump") and kirby.is_on_floor():
		Transitioned.emit(self,"beamkirbyjumpingstate")
	kirby.direction = Input.get_axis("move_left", "move_right")
	if kirby.direction:
		Transitioned.emit(self,"beamkirbywalkstate")
func Enter():
	kirby.isBeam = true
	if animated_sprite_2d != null:
		animated_sprite_2d.queue_free()
	beam_kirby.visible = true
	beam_kirby.play("idle")
func Exit():
	pass
