extends Node2D

signal spawn_node(node)
signal no_nodes_in_area(spawn_area)
signal node_spawned(spawn_area, node_count)
signal node_exiting(spawn_area, node, node_count)

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
	spawned_nodes_in_area += 1
	var new_node = scene_to_spawn.instance()
	new_node.global_position = get_random_pos_in_area()
	new_node.connect("tree_entered", self, "_on_node_entering_the_tree")
	emit_signal("spawn_node", new_node)


func _on_node_entering_the_tree():
	spawned_nodes_in_area += 1
	emit_signal("node_spawned", self, spawned_nodes_in_area)


func _on_node_exiting_the_tree(node:Node):
	spawned_nodes_in_area -= 1
	emit_signal("node_exiting", self, node)
	if(spawned_nodes_in_area==0):
		emit_signal("no_nodes_in_area", self, spawned_nodes_in_area)


func _on_Timer_timeout():
	spawn()
