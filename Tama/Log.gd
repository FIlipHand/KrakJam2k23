extends StaticBody2D

func hide():
	$".".visible = false
	$CollisionShape2D.disabled = true

func show():
	$".".visible = true
	$CollisionShape2D.disabled = false
