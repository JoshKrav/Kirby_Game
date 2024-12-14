extends State
class_name InhaleState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var suck_collision: CollisionShape2D = $"../../Suck/SuckCollision"
@onready var kirby: Kirby = $"../.."
@onready var timer: Timer = $"../../Timer"
@onready var cool_down_timer: Timer = $"../../CoolDownTimer"
var unSucking = false;
func Enter():
	animated_sprite_2d.play("suck")
	suck_collision.disabled=false
	kirby.direction = 0
	kirby.velocity.y = 0
	kirby.velocity.x = 0
	timer.start(.75)

func Update(delta):
	
	if Input.is_action_just_released("suck") && unSucking == false:
		cool_down_timer.start(.75)
		unSucking == true
		animated_sprite_2d.play("unsuck")
func _on_timer_timeout() -> void:
	animated_sprite_2d.stop()
	animated_sprite_2d.frame = 2 
	pass # Replace with function body.


func _on_cool_down_timer_timeout() -> void:
	suck_collision.disabled = true
	Transitioned.emit(self,"idlestate")
	pass # Replace with function body.
