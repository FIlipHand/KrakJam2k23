extends Node2D

# add scenes of growth stages
export var growth_stages:Array = []
export var start_growth_stage:int = 0 # used only to start growth_stage at start
onready var growth_stage:int = start_growth_stage -1

signal drzewo_uroslo(new_stage)

func _ready():
	grow_tree()


# makes the tree grow to the next stage
func grow_tree():
	var max_stage = len(growth_stages) - 1
	
	if growth_stage >= max_stage:
		# tree in the max stage
		return
	
	growth_stage+=1

	# Replace tree node with a new tree
	var treeScene:PackedScene = growth_stages[growth_stage]
	var new_tree = treeScene.instance()
	
	if get_child_count() > 0:
		remove_child(get_child(0))

	add_child(new_tree)
	new_tree.connect("ready_to_grow", self, "grow_tree")
	emit_signal("drzewo_uroslo", growth_stage)
