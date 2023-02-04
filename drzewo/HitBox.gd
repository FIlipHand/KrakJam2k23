extends Area2D

onready var drzewo = get_parent()

func take_damege():
	drzewo.get_hit()
