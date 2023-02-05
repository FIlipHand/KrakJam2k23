extends Area2D

signal hit_taken()

func _on_attacked():
	emit_signal("hit_taken")
