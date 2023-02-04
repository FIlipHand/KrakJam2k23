extends StaticBody2D

signal ready_to_grow()

export var seconds_to_grow:float = 10

func _on_GrowthTimer_timeout():
	emit_signal("ready_to_grow")
