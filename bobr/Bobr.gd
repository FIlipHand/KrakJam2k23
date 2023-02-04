extends KinematicBody2D

var velocity = Vector2.ZERO

const MAX_SPEED = 350

func _physics_process(_delta):
	var input_vec = Vector2.ZERO
	input_vec.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vec.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vec = input_vec.normalized() * MAX_SPEED

	velocity = move_and_slide(input_vec)
	
	if Input.is_action_just_pressed("hit"):
		bite()

func bite():
	# TODO tutaj jakoś animacja będzie więc to inaczej i tak będize działało
	$AttackShape/CollisionShape2D.disabled = !$AttackShape/CollisionShape2D.disabled

func _on_AttackShape_area_entered(area: Area2D):
	if area.is_in_group('TreeHitBox'):
		area.take_damege()
