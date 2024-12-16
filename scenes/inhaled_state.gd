extends State
class_name InhaledIdleState

@onready var kirby: Kirby = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func Update(delta):
	if Input.is_action_just_pressed("suck"):
		Transitioned.emit(self,"shootstarstate")
	if Input.is_action_just_pressed("jump") and kirby.is_on_floor():
		Transitioned.emit(self,"inhaledjumpingstate")
	if Input.is_action_just_pressed("crouch") && kirby.swallowed_entity[0] == "waddle_doo":
		audio_stream_player_2d.play()
		Transitioned.emit(self,"beamkirbyidlestate")
	elif Input.is_action_just_pressed("crouch") && kirby.swallowed_entity[0] == "waddle_dee":
		Transitioned.emit(self,"idlestate")
	kirby.direction = Input.get_axis("move_left", "move_right")
	if kirby.direction:
		Transitioned.emit(self,"inhaledwalkingstate")
func Enter():
	animated_sprite_2d.play("swallowed_idle")
func Exit():
	pass


func _on_audio_stream_player_2d_finished() -> void:
	audio_stream_player_2d.stop()
