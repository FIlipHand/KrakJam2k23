extends ColorRect

signal fade_in_finished()
signal fade_out_finished()


func fade_in() -> void:
	visible = true
	var tween = Tween.new()
	tween.interpolate_property(self, "modulate", Color(0, 0, 0, 1), Color(1, 1, 1, 0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.connect("tween_completed", self, "_on_fade_in_completed")
	add_child(tween)
	tween.start()

func fade_out() -> void:
	visible = true
	var tween = Tween.new()
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(0, 0, 0, 1), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.connect("tween_completed", self, "_on_fade_out_completed")
	add_child(tween)
	tween.start()
	
func _on_fade_in_completed(_object, _key) -> void:
	emit_signal("fade_in_finished")

func _on_fade_out_completed(_object, _key) -> void:
	emit_signal("fade_out_finished")
	
