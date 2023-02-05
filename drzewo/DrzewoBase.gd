
extends StaticBody2D

signal ready_to_grow()
signal drzewo_killed()
signal spawn_log(logNode)

export var MAX_HP: int = 3

export var hit_particle: PackedScene

onready var current_hp = MAX_HP

onready var tree_log = preload("res://tama/Log.tscn")

var rng = RandomNumberGenerator.new()


func _on_GrowthTimer_timeout():
	emit_signal("ready_to_grow")

func drop_log():
	var log_instance: StaticBody2D = tree_log.instance()
	var vec_rand = Vector2(rng.randf_range(-50, 50), rng.randf_range(-50, 50))
	log_instance.position = vec_rand
	emit_signal("spawn_log", log_instance)


func on_hit():
	var particle = hit_particle.instance()
	particle.position = global_position
	particle.emitting = true
	get_tree().current_scene.add_child(particle)

	drop_log()
	current_hp -= 1
	if current_hp <= 0:
		hide()
		emit_signal("drzewo_killed")

