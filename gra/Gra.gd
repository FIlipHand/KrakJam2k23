extends Node

export var tree_spawner_rate:float = 1
export var tree_spawner_varience:float = 10
export var trees_per_progression:int = 2
export var max_tree_count:int = 35

var total_tree_count:int = 0
var min_spawn_area_x:float = 0
onready var roots_spawn_area = get_node("YSort/Bobr/RootsSpawnArea")

func _ready():
	for spawnArea in [$YSort/SpawnAreaGora, $YSort/SpawnAreaDol]:
		spawnArea.spawn_rate = tree_spawner_rate
		spawnArea.spawn_rate_varience = tree_spawner_varience
		spawnArea.start_spawning()
		min_spawn_area_x = spawnArea.get_node("ReferenceRect").rect_global_position.x

func _process(_delta):
	$Control/BobrWinBar.value = $YSort/Tama.total_log_count * 100 / $YSort/Tama.MAX_FILL
	$Control2/TreeWinBar.value = 100 * total_tree_count / float(max_tree_count)

func attack_with_roots():
	roots_spawn_area.spawn()

func shift_spawn_area(spawn_area, xMulitplier):
	var refRect = spawn_area.get_node("ReferenceRect")
	var xOffset:float = refRect.rect_size.x * xMulitplier
	var newPos = refRect.rect_global_position + Vector2(xOffset, 0)
	# wont shift beyond screen
	if (newPos.x > 0):
		refRect.rect_global_position = newPos

	


func _on_SpawnArea_spawn_node(node):
	$YSort.call_deferred("add_child", node)


func _on_SpawnArea_drzewo_spawned(spawn_area, node_count):
	total_tree_count += 1
	if(node_count > 0 && node_count % trees_per_progression == 0):
		# move spawn area forward
		shift_spawn_area(spawn_area, 1)
	if total_tree_count >= max_tree_count:
		_on_game_lose()


func _on_SpawnArea_drzewo_exiting(_spawn_area, _node_count):
	total_tree_count -= 1


func _on_SpawnArea_no_drzewo_in_area(spawn_area):
	# move spawn area forward
	# shift_spawn_area(spawn_area, -1)
	pass


func _on_RootsAttackTimer_timeout():
	attack_with_roots()


func _on_game_won():
	$Mapa.stop()
	$Mapa/WyschnietaRzeka.play()
	$Mapa/WyschnietaRzeka.visible = true
	get_tree().change_scene("res://ekrany/EkranZwyciestwa.tscn")

func _on_game_lose():
	get_tree().change_scene("res://ekrany/EkranPorazki.tscn")
