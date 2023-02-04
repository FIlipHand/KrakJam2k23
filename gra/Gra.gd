extends Node

export var tree_spawner_rate:float = 1
export var tree_spawner_varience:float = 10
export var trees_per_progression:int = 2

var total_tree_count:int = 0
var min_spawn_area_x:float = 0
onready var roots_spawn_area = get_node("YSort/Bobr/RootsSpawnArea")

func _ready():
	for spawnArea in [$YSort/SpawnAreaGora, $YSort/SpawnAreaDol]:
		spawnArea.spawn_rate = tree_spawner_rate
		spawnArea.spawn_rate_varience = tree_spawner_varience
		spawnArea.start_spawning()
		min_spawn_area_x = spawnArea.get_node("ReferenceRect").rect_global_position.x

func attack_with_roots():
	roots_spawn_area.spawn()

func shift_spawn_area(spawn_area, xMulitplier):
	var refRect = spawn_area.get_node("ReferenceRect")
	var xOffset:float = refRect.rect_size.x * xMulitplier
	refRect.rect_global_position += Vector2(xOffset, 0)


func _on_SpawnArea_spawn_node(node):
	$YSort.add_child(node)


func _on_SpawnArea_node_spawned(spawn_area, node_count):
	total_tree_count += 1

	if(node_count > 0 && node_count % trees_per_progression == 0):
		# move spawn area forward
		shift_spawn_area(spawn_area, 1)


func _on_SpawnArea_node_exiting(_spawn_area, _node_count):
	total_tree_count -= 1

func _on_SpawnArea_no_nodes_in_area(spawn_area):
	# move spawn area forward
	shift_spawn_area(spawn_area, -1)

func _on_RootsAttackTimer_timeout():
	attack_with_roots()

func _on_game_won():
	$Mapa.stop()
	$Mapa/WyschnietaRzeka.play()
	$Mapa/WyschnietaRzeka.visible = true
