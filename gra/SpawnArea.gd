extends Node2D

signal no_nodes_in_area()
signal node_spawned(node, node_count)
signal node_exiting(node, node_count)

export var spawn_rate:float = 3
export var spawn_rate_varience:float = 0.5
export (PackedScene) var scene_to_spawn

var spawned_nodes_in_area:int = 0


func start_spawning():
	if $Timer.is_stopped():
		$Timer.start(spawn_rate + rand_range(0, spawn_rate_varience))


func stop_spawning():
	$Timer.stop()

func get_random_pos_in_area()->Vector2:

	var width: float = $ReferenceRect.rect_size.x
	var height: float = $ReferenceRect.rect_size.y
	var x = $ReferenceRect.rect_global_position.x + rand_range(0, width)
	var y = $ReferenceRect.rect_global_position.y + rand_range(0, height)
	return Vector2(x,y)

func spawn():
	var new_node = scene_to_spawn.instance()
	$SpawnedNodes.add_child(new_node)
	new_node.global_position = get_random_pos_in_area()
	emit_signal("node_spawned", new_node, $SpawnedNodes.get_child_count())


func _on_node_exiting_the_tree(node:Node):
	spawned_nodes_in_area -= 1
	emit_signal("node_exiting", node)
	if(spawned_nodes_in_area==0):
		emit_signal("no_nodes_in_area")


func _on_Timer_timeout():
	spawn()
