extends State
class_name BeamKirbyJumpingState
const JUMP_VELOCITY = -350.0
@onready var kirby: CharacterBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var suck: Area2D = $"../../Suck"
var SPEED = 100.0
@onready var beam_kirby: AnimatedSprite2D = $"../../BeamKirby"

func Enter():
	beam_kirby.play("jump")
	kirby.velocity.y = JUMP_VELOCITY

func Physics_Update(delta):
	if kirby.direction > 0:
		beam_kirby.flip_h = false
		suck.scale.x = 1
	elif kirby.direction < 0:
		beam_kirby.flip_h = true
		suck.scale.x = -1
	if kirby.is_on_floor():   
		Transitioned.emit(self,"beamkirbyidlestate")
	kirby.direction = Input.get_axis("move_left", "move_right")
	if kirby.direction:
		kirby.velocity.x = kirby.direction * SPEED
func Exit():
	kirby.velocity.x=0.0
