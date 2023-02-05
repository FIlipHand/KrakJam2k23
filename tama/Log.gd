extends StaticBody2D

export var FILL_RATE: int = 5

func hide():
	$".".visible = false
	$CollisionShape2D.disabled = true

func show():
	$".".visible = true
	$CollisionShape2D.disabled = false
