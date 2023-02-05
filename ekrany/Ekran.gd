extends AnimatedSprite

export var skip_fade_in:bool = false
export var skip_fade_out:bool = false
export (PackedScene)var next_scene

var fade_out_started:bool = false

func _ready():
	$AudioStreamPlayer2D.play()
	$FadeTransition.connect("fade_in_finished", self, "_on_fade_in_finished")
	$FadeTransition.connect("fade_out_finished", self, "_on_fade_out_finished")
	
	if(skip_fade_in):
		_on_fade_in_finished()
	else:
		$FadeTransition.fade_in()
	
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") && !fade_out_started:
		if(skip_fade_out):
			_on_fade_out_finished()
		else:
			$FadeTransition.fade_out()
			fade_out_started = true
			
func _on_fade_in_finished():
	play()

func _on_fade_out_finished():
	get_tree().change_scene_to(next_scene)
