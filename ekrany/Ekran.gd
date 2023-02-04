extends TextureRect

export (PackedScene)var next_scene

func _process(_delta):
	if Input.get_action_strength("ui_accept"):
		get_tree().change_scene_to(next_scene)