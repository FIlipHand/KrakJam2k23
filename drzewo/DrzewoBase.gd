extends StaticBody2D

signal ready_to_grow()

export var MAX_HP: int = 3

onready var current_hp = MAX_HP

onready var tree_log = preload("res://Tama/Log.tscn")

var rng = RandomNumberGenerator.new()


func _on_GrowthTimer_timeout():
	emit_signal("ready_to_grow")

func drop_log():
	var log_instance: StaticBody2D = tree_log.instance()
	var vec_rand = Vector2(rng.randf_range(-50, 50), rng.randf_range(-50, 50))
	log_instance.position += vec_rand
	get_parent().call_deferred("add_child", log_instance)


func on_hit():
	drop_log()
	current_hp -= 1
	if current_hp == 0:
		queue_free()

