extends CharacterBody2D

@export var SPEED = 100

var dir: float
var spawnPos: Vector2
var zdex: int

func _ready():
	global_position = spawnPos
	z_index = zdex
	
func _physics_process(delta: float) -> void:
	move_and_slide()
