extends ProgressBar

@onready var game_manager: Node = %GameManager

func _ready():
	game_manager.HealthChanged.connect(update)
	update()
func update():
	value = game_manager.health * 100 / game_manager.maxHealth
