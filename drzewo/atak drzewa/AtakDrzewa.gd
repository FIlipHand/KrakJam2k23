extends Area2D

export var HP:int = 2

onready var frames_count = $AnimatedSprite.frames.get_frame_count("default")
var player = null

func attack():
	var caught:bool = false
	for body in get_overlapping_bodies():
		if(body.is_in_group("player")):
			player = body
			_on_player_caught()
			caught = true
	if caught:
		_on_caught()
	else:
		queue_free()


# jeśli złapie coś rootsami
func _on_caught():
	# sets the last frame where it is caught
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = frames_count-1 #$AnimatedSprite.frames.get_frame("default", frames_count-1)


func _on_player_caught():
	if player != null:
		player.movement_enabled = false


func _on_AnimatedSprite_frame_changed():
	if ($AnimatedSprite.frame == frames_count-1):
		attack()

func _on_attacked():
	HP -= 1

	if(HP <= 0):
		if player!=null:
			player.movement_enabled = true
		hide()
		queue_free()
