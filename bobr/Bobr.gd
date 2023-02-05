extends KinematicBody2D

const MAX_SPEED = 400

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

var velocity = Vector2.ZERO
var movement_enabled:bool = true
var picked_log = null

enum direction {
	N, W, E, S
}

var facing = direction.E

enum {
	MOVE,
	BITE
}

var bubr_state = MOVE

func _ready():
	$TreeRootTimer.connect("timeout", self, "_on_tree_root_timeout")
	animationTree.active = true
	$AttackShape/CollisionShape2D.disabled = true

func _process(_delta):
	if bubr_state == BITE:
		return
	# 	$AttackShape/CollisionShape2D.disabled = true
	if Input.is_action_just_pressed("hit"):
		if picked_log == null:
			if bubr_state == BITE:
				bubr_state = MOVE
			else:
				bubr_state = BITE
	
	if Input.is_action_just_pressed("pick_drop"):
		pick_or_drop()

	match bubr_state:
		MOVE:
			do_movement()
		BITE:
			animationState.travel("Bite")
		

func do_movement():
	$AttackShape/CollisionShape2D.disabled = true
	var input_vec = Vector2.ZERO
	input_vec.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vec.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vec = input_vec.normalized() * MAX_SPEED * (0.7 if picked_log != null else 1.0) * (1.0 if movement_enabled else 0.0001)
	
	var x_qt_y = abs(input_vec.x) > abs(input_vec.y)
	if x_qt_y:
		facing = direction.E if input_vec.x > 0 else direction.W
	else:
		facing = direction.S if input_vec.y > 0 else direction.N
	
	match facing:
		1:
			$AttackShape.scale.x = 1
		2:
			$AttackShape.scale.x = -1
		0:
			pass # TODO? ? ?
		3:
			pass
	if input_vec != Vector2.ZERO:
		animationTree.set('parameters/Walk/blend_position', input_vec)
		animationTree.set('parameters/Idle/blend_position', input_vec)
		animationTree.set('parameters/Bite/blend_position', input_vec)
		animationTree.set('parameters/LogWalk/blend_position', input_vec)
		animationTree.set('parameters/IdleLog/blend_position', input_vec)
		if picked_log != null:
			animationState.travel("LogWalk")
		else:
			animationState.travel("Walk")
		velocity = move_and_slide(input_vec)
	else:
		if picked_log != null:
			animationState.travel("IdleLog")
		else:
			animationState.travel("Idle")

func pick_or_drop():
	if picked_log != null:
		if movement_enabled:
			picked_log.global_position = self.global_position
			picked_log.show()
			picked_log = null
		else:
			picked_log.queue_free()
			picked_log = null
	else:
		if len($PickUpBox.get_overlapping_areas()) > 0:
			var possible_log_object = $PickUpBox.get_overlapping_areas()[0] # to może generowac błędy
			if possible_log_object.is_in_group("LogPickUp"):
				animationState.travel("LogWalk")
				picked_log = possible_log_object.get_parent()
				picked_log.hide()

func drop_log_to_tama():
	if picked_log != null:
		rotation_degrees = 0
		picked_log.queue_free()
		picked_log = null


func _on_AttackShape_area_entered(area: Area2D):
	if area.is_in_group('attackable'):
		area._on_attacked()

func bite_animation_finish():
	bubr_state = MOVE
	do_movement()
