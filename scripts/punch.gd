extends Area2D

@onready var kirby: CharacterBody2D = $".."


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		area.get_parent().knockedback = true
		if kirby.lookRight == true:
			area.get_parent().knockDirection = 1
		elif kirby.lookLeft == true:
			area.get_parent().knockDirection = -1
		area._take_damage()
