extends KinematicBody2D

var velocity = Vector2.ZERO

const MAX_SPEED = 350

func _physics_process(delta):
	var input_vec = Vector2.ZERO
	input_vec.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vec.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vec = input_vec.normalized() * MAX_SPEED

	velocity = move_and_slide(input_vec)


func _on_AttackShape_area_entered(area):
	print('krowa')
