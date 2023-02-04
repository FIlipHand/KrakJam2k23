extends KinematicBody2D

var velocity = Vector2.ZERO

const MAX_SPEED = 350

var picked_log = null

func _physics_process(_delta):
	var input_vec = Vector2.ZERO
	input_vec.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vec.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vec = input_vec.normalized() * MAX_SPEED * (0.6 if picked_log != null else 1.0)

	velocity = move_and_slide(input_vec)
	
	if Input.is_action_just_pressed("hit"):
		bite()
	
	# Podnoszenie kłody
	if Input.is_action_just_pressed("pick_drop"):
		pick_or_drop()
				
func pick_or_drop():
	if picked_log != null:
		picked_log.global_position = self.global_position
		self.rotation_degrees = 0
		picked_log.show()
		picked_log = null
	else:
		if len($PickUpBox.get_overlapping_areas()) > 0:
			var possible_log_object = $PickUpBox.get_overlapping_areas()[0] # to może generowac błędy
			if possible_log_object.is_in_group("LogPickUp"):
				picked_log = possible_log_object.get_parent()
				self.rotation_degrees = 180
				picked_log.hide()

func drop_log_to_tama():
	if picked_log != null:
		rotation_degrees = 0
		picked_log.queue_free()
		picked_log = null

func bite():
	# TODO tutaj jakoś animacja będzie więc to inaczej i tak będize działało
	$AttackShape/CollisionShape2D.disabled = !$AttackShape/CollisionShape2D.disabled

func _on_AttackShape_area_entered(area: Area2D):
	if area.is_in_group('TreeHitBox'):
		area.take_damege()
