extends State
class_name BeamKirbyFloatingState
const JUMP_VELOCITY = -350.0
@onready var kirby: CharacterBody2D = $"../.."
@onready var beam_kirby: AnimatedSprite2D = $"../../BeamKirby"

@onready var suck: Area2D = $"../../Suck"
@onready var float_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D


var SPEED = 100.0
func Enter():
	beam_kirby.play("float")
	kirby.velocity.y = JUMP_VELOCITY
	kirby.isFloating = true
	float_sound.play()
func Exit():
	kirby.isFloating = false
	float_sound.stop()
func Physics_Update(delta):
	if kirby.direction > 0:
		beam_kirby.flip_h = false
		suck.scale.x = 1
	elif kirby.direction < 0:
		beam_kirby.flip_h = true
		suck.scale.x = -1
	if Input.is_action_just_pressed("jump"):
		beam_kirby.play("float")
		float_sound.play()
		kirby.velocity.y = JUMP_VELOCITY
	if kirby.is_on_floor():   
		Transitioned.emit(self,"beamkirbyidlestate")
	kirby.direction = Input.get_axis("move_left", "move_right")
	if kirby.direction:
		kirby.velocity.x = kirby.direction * SPEED
	


func _on_audio_stream_player_2d_finished() -> void:
	float_sound.stop()


func _on_animated_sprite_2d_animation_finished() -> void:
	beam_kirby.play("float_hover")
	pass # Replace with function body.
