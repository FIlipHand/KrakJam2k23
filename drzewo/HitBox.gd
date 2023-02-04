extends Area2D

signal hit_taken()

func take_damege():
	print("Hitbox hit")
	emit_signal("hit_taken")
