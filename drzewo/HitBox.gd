extends Area2D

signal hit_taken()

func _on_attacked():
	print("Hitbox hit")
	emit_signal("hit_taken")
