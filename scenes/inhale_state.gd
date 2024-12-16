extends State
class_name InhaleState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var suck_collision: CollisionShape2D = $"../../Suck/SuckCollision"
@onready var kirby: Kirby = $"../.."
@onready var timer: Timer = $"../../Timer"
@onready var inhale_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
var inhale_stale_frame = 2
var timer_time = .75
@onready var cool_down_timer: Timer = $"../../CoolDownTimer"
var unSucking = false;
func Enter():
	animated_sprite_2d.play("suck")
	suck_collision.disabled=false
	kirby.direction = 0
	kirby.velocity.y = 0
	kirby.velocity.x = 0
	inhale_sound.play()
	timer.start(timer_time)

func Update(delta):
	
	if Input.is_action_just_released("suck") && unSucking == false:
		cool_down_timer.start(timer_time)
		unSucking == true
		animated_sprite_2d.play("unsuck")
func _on_timer_timeout() -> void:
	animated_sprite_2d.stop()
	animated_sprite_2d.frame = inhale_stale_frame
	pass # Replace with function body.

func Exit():
	inhale_sound.stop()
func _on_cool_down_timer_timeout() -> void:
	suck_collision.disabled = true
	Transitioned.emit(self,"idlestate")
	pass # Replace with function body.


func _on_audio_stream_player_2d_finished() -> void:
	inhale_sound.play(1)   
