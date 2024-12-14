extends State
class_name ShootStarState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var suck_collision: CollisionShape2D = $"../../Suck/SuckCollision"
@onready var kirby: Kirby = $"../.."
@onready var timer: Timer = $"../../Timer"
@onready var game: Node2D = $"../.."
@onready var StarScene = preload("res://scenes/star.tscn")
@onready var cool_down_timer: Timer = $"../../CoolDownTimer"
@onready var spitout_timer: Timer = $"../../SpitoutTimer"
@onready var star_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

var unSucking = false;
func Enter():
	var star = StarScene.instantiate()
	star.spawnPos = kirby.global_position
	star.zdex = kirby.z_index - 1
	if animated_sprite_2d.flip_h == false:
		star.velocity = Vector2(200, 0)
	else:
		star.velocity = Vector2(-200,0)
	game.add_child.call_deferred(star)
	spitout_timer.start(.7)
	animated_sprite_2d.play("unsuck")
	star_sound.play()

func Update(delta):
	pass

func _on_spitout_timer_timeout() -> void:
	Transitioned.emit(self,"idlestate")


func _on_audio_stream_player_2d_finished() -> void:
	star_sound.stop()
