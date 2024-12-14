extends CharacterBody2D
class_name Kirby
var direction = null

var swallowed = false

@onready var suck_collision: CollisionShape2D = $Suck/SuckCollision

var inSpitOut = false

var lookLeft = false

var lookRight = false

var hurt = false

var swallowed_entity

var isBeam = false

@onready var label: RichTextLabel = $RichTextLabel

var isSucking = false

var isPunching = false
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
