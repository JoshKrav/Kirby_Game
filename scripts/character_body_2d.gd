extends CharacterBody2D


var SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var kirby: CharacterBody2D = $"."
var run = false


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var beam_kirby: AnimatedSprite2D = $BeamKirby

@onready var timer: Timer = $Timer

@onready var StarScene = preload("res://scenes/star.tscn")

@onready var cool_down_timer: Timer = $CoolDownTimer

@onready var game: Node2D = $".."

@onready var suck: Area2D = $Suck

@onready var suck_collision: CollisionShape2D = $Suck/SuckCollision

@onready var spitout_timer: Timer = $SpitoutTimer

var swallowed = false

var inSpitOut = false

var hurt = false

var swallowed_entity

var crouching = false

var direction = null

var isBeam = false

var isSucking = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("run"):
		run = true
		SPEED = 150
	
	
	if Input.is_action_just_released("crouch") && swallowed == true:
		if swallowed_entity[0] == "waddle_doo":
			animated_sprite.queue_free()
			isBeam = true
			swallowed=false
			suck_collision.disabled = true
			beam_kirby.visible = true
			
	if Input.is_action_just_pressed("suck") && swallowed == true && isBeam == false:
		var star = StarScene.instantiate()
		star.spawnPos = global_position
		star.zdex = z_index - 1
		if animated_sprite.flip_h == false:
			star.velocity = Vector2(200, 0)
		else:
			star.velocity = Vector2(-200,0)
		game.add_child.call_deferred(star)
		inSpitOut = true
		spitout_timer.start(.7)
		animated_sprite.play("unsuck")

	if Input.is_action_just_pressed("walk"):
		run = false
		SPEED = 100
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("suck") && swallowed == false && isBeam == false:
		isSucking = true
		animated_sprite.play("suck")
		timer.start(.75)
		suck_collision.disabled = false
		direction = 0
		velocity.y = 0
		velocity.x = 0
	else:
		direction = Input.get_axis("move_left", "move_right")
		if isBeam == true:
			if direction > 0:
				beam_kirby.flip_h = false
			elif direction < 0:
				beam_kirby.flip_h = true
		else:
			if direction > 0:
				animated_sprite.flip_h = false
				suck.scale.x = 1
			elif direction < 0:
				animated_sprite.flip_h = true
				suck.scale.x = -1
	
	if direction != null && isSucking == false && inSpitOut == false:
		if hurt == true:
			if isBeam == true:
				beam_kirby.play("hurt")
			else:
				animated_sprite.play("hurt")
		elif swallowed == true:
			if is_on_floor():
				if direction == 0:
					animated_sprite.play("swallowed_idle")
				else:
					animated_sprite.play("swallowed_walk")
			else:
				animated_sprite.play("swallowed_jump")
		elif isBeam == true:
			if is_on_floor():
				if direction == 0:
					beam_kirby.play("idle")
				elif run == true:
					beam_kirby.play("run")
				else:
					beam_kirby.play("walk")
			else:
				beam_kirby.play("jump")
		else:
			if is_on_floor():
				if direction == 0:
					animated_sprite.play("idle")
				elif run == true:
					animated_sprite.play("run")
				else:
					animated_sprite.play("walk")
			else:
				animated_sprite.play("jump")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_released("suck") && swallowed == false:
		cool_down_timer.start(.75)
		animated_sprite.play("unsuck")
	move_and_slide()



func _on_timer_timeout() -> void:
	animated_sprite.stop()
	animated_sprite.frame = 2 


func _on_cool_down_timer_timeout() -> void:
		isSucking = false
		suck_collision.disabled = true
		animated_sprite.play("idle")

func _on_spitout_timer_timeout() -> void:
	swallowed = false
	inSpitOut = false
