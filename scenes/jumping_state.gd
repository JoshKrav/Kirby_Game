extends State
class_name JumpingState
const JUMP_VELOCITY = -350.0
@onready var kirby: CharacterBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var SPEED = 100.0
func Enter():
	animated_sprite_2d.play("jump")
	kirby.velocity.y = JUMP_VELOCITY

func Physics_Update(delta):
	kirby.direction = Input.get_axis("move_left", "move_right")
	if kirby.direction:
		kirby.velocity.x = kirby.direction * SPEED
	if kirby.is_on_floor():   
		Transitioned.emit(self,"IdleState")
