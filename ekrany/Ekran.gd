extends TextureRect

export (PackedScene)var next_scene

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to(next_scene)
