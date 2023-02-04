extends Node

export var trees_per_progression:int = 2
var total_tree_count:int = 0

func _ready():
	$YSort/SpawnAreaGora.start_spawning()
	$YSort/SpawnAreaDol.start_spawning()



func shift_spawn_area(spawn_area, xMulitplier):
	var xOffset:float = spawn_area.get_node("ReferenceRect").rect_size.x * xMulitplier
	spawn_area.get_node("ReferenceRect").rect_global_position += Vector2(xOffset, 0)


func _on_SpawnArea_node_spawned(spawn_area, _node, node_count):
	total_tree_count += 1

	if(node_count > 0 && node_count % trees_per_progression == 0):
		# move spawn area forward
		shift_spawn_area(spawn_area, 1)


func _on_SpawnArea_node_exiting(_spawn_area, _node, _node_count):
	total_tree_count -= 1

func _on_SpawnArea_no_nodes_in_area(spawn_area):
	# move spawn area forward
	shift_spawn_area(spawn_area, -1)
