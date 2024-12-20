extends State
class_name JumpingState
const JUMP_VELOCITY = -350.0
@onready var kirby: CharacterBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var suck: Area2D = $"../../Suck"
@onready var jump_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

var SPEED = 100.0
func Enter():
	animated_sprite_2d.play("jump")
	kirby.velocity.y = JUMP_VELOCITY
	jump_sound.play()
func Physics_Update(delta):
	if kirby.direction > 0:
		animated_sprite_2d.flip_h = false
		suck.scale.x = 1
	elif kirby.direction < 0:
		animated_sprite_2d.flip_h = true
		suck.scale.x = -1
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self,"floatingstate")
	if kirby.is_on_floor():   
		Transitioned.emit(self,"IdleState")
	kirby.direction = Input.get_axis("move_left", "move_right")
	if kirby.direction:
		kirby.velocity.x = kirby.direction * SPEED
	


func _on_audio_stream_player_2d_finished() -> void:
	jump_sound.stop()
