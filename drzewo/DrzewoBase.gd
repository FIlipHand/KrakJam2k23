extends StaticBody2D

signal ready_to_grow()

export var MAX_HP: int = 3

onready var current_hp = MAX_HP


func _on_GrowthTimer_timeout():
	emit_signal("ready_to_grow")


func on_hit():
	current_hp -= 1
	if current_hp == 0:
		queue_free()
