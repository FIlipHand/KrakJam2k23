extends Area2D

export var HP:int = 2

onready var frames_count = $AnimatedSprite.frames.get_frame_count("default")
var player = null

func _ready():
	$RootTimer.connect("timeout", self, "_on_RootTimer_timeout")

func attack():
	for body in get_overlapping_bodies():
		if(body.is_in_group("player")):
			player = body
			_on_caught()
			_on_player_caught()


# jeśli złapie coś rootsami
func _on_caught():
	$AnimatedSprite.stop()


func _on_player_caught():
	player.movement_enabled = false
	$RootTimer.start()


func _on_RootTimer_timeout():
	if player!=null:
		player.movement_enabled = true

func _on_AnimatedSprite_frame_changed():
	if ($AnimatedSprite.frame == frames_count-1):
		attack()

func _on_attacked():
	HP -= 1

	if(HP <= 0):
		player.movement_enabled = true
		queue_free()
