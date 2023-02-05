extends Area2D

export var HP:int = 2

var player = null

func _ready():
	$AnimatedSprite.play()

func catch():
	$AnimatedSprite.animation = "catch"
	var caught:bool = false
	for body in get_overlapping_bodies():
		if(body.is_in_group("player")):
			player = body
			_on_player_caught()
			caught = true
	if caught:
		_on_caught()
	else:
		_on_failed_catch()

func _on_failed_catch():
	$AnimatedSprite.animation = "failed catch"
	$AnimatedSprite.frame = 0

# jeśli złapie coś rootsami
func _on_caught():
	# sets the last frame where it is caught
	HP += 1
	$AnimatedSprite.stop()

func _on_player_caught():
	if player != null:
		player.movement_enabled = false


func _on_attacked():
	HP -= 1

	if(HP <= 0):
		if player!=null:
			player.movement_enabled = true
		hide()
		queue_free()


func _on_AtakDrzewa_body_entered(body:Node):
	$AnimatedSprite.play("catch")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "catch":
		catch()

	elif ($AnimatedSprite.animation == "failed catch"):
		$AnimatedSprite.play("default")
		# hide()
		# queue_free()
