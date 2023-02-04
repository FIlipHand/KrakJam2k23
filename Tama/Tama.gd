extends Area2D

export var MAX_FILL: int = 100
onready var current_fill: int = 0




func _on_Node2D_area_entered(area: Area2D):
	if area.is_in_group("Player"):
		var player = area.get_parent()
		player.drop_log_to_tama()
