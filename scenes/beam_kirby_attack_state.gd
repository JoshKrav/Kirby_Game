extends State
class_name BeamKirbyAttackState

@onready var kirby: Kirby = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var beam_kirby_attack: AnimatedSprite2D = $"../../BeamKirbyAttack"
@onready var beam_kirby: AnimatedSprite2D = $"../../BeamKirby"
@onready var punch_timer: Timer = $"../../PunchTimer"
@onready var punch_collision: CollisionShape2D = $"../../Punch/PunchCollision"


func Enter():
	beam_kirby_attack.play("punch")
	punch_timer.start(1.3)
	beam_kirby_attack.visible = true
	punch_collision.disabled = false
	beam_kirby.visible = false
func Exit():
	pass

func Update(delta):
	if kirby.direction > 0:
		beam_kirby_attack.flip_h = false
	elif kirby.direction < 0:
		beam_kirby_attack.flip_h = true
func _on_punch_timer_timeout() -> void:
	punch_collision.disabled = true
	beam_kirby.visible = true
	beam_kirby_attack.visible = false
	Transitioned.emit(self,"beamkirbyidlestate")
