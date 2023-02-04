extends StaticBody2D

export var MAX_HP: int = 3

onready var current_hp = MAX_HP

func get_hit():
	current_hp -= 1
	if current_hp == 0:
		queue_free()
