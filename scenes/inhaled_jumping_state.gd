extends State
class_name InhaledJumpingState
const JUMP_VELOCITY = -350.0
@onready var kirby: CharacterBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var suck: Area2D = $"../../Suck"
@onready var jump_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

var SPEED = 100.0

func Enter():
	animated_sprite_2d.play("swallowed_jump")
	kirby.velocity.y = JUMP_VELOCITY
	jump_sound.play()
func Physics_Update(delta):
	if kirby.direction > 0:
		animated_sprite_2d.flip_h = false
		suck.scale.x = 1
	elif kirby.direction < 0:
		animated_sprite_2d.flip_h = true
		suck.scale.x = -1
	if kirby.is_on_floor():   
		Transitioned.emit(self,"InhaledIdleState")
	kirby.direction = Input.get_axis("move_left", "move_right")
	if kirby.direction:
		kirby.velocity.x = kirby.direction * SPEED
func Exit():
	kirby.velocity.x=0.0


func _on_audio_stream_player_2d_finished() -> void:
	jump_sound.stop()
