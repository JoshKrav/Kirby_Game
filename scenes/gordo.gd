extends Game_Object

@onready var kirby: CharacterBody2D = get_node("/root/Game/Kirby")

@onready var game_manager: Node = get_node("/root/Game/GameManager")

var tween: Tween
var start_position: Vector2
var end_position: Vector2

func _ready() -> void:
	tween = create_tween()
	start_position = self.position
	end_position = start_position + Vector2(0, 50)
	move_up_and_down()
func _process(delta:float) -> void:
	pass

func on_collision(body: Node2D):
	if body == kirby:
		game_manager.take_damage()
		kirby.velocity.x = -200
		kirby.velocity.y = -200
func move_up_and_down():
	tween.tween_property(self, "position", end_position,2)
	tween.tween_property(self, "position", start_position,2)
	tween.set_loops()
func start_tween_loop() -> void:
	tween.tween_property(self, "position", end_position, 2)  # 4 arguments: object, property, end value, duration
	tween.connect("tween_all_completed", _on_tween_up_finished)

# Callback for when the up movement finishes
func _on_tween_up_finished():
	tween.tween_property(self, "position", start_position, 2)  # 4 arguments: object, property, end value, duration
	
	tween.connect("tween_all_completed", _on_tween_down_finished)

# Callback for when the down movement finishes
func _on_tween_down_finished():
	tween.tween_property(self, "position", end_position, 2)  # 4 arguments: object, property, end value, duration
	tween.connect("tween_all_completed",_on_tween_up_finished)
