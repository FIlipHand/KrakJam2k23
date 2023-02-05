extends Area2D

signal log_brought(total_logs_count)
signal tama_built()

export var MAX_FILL: int = 10
export var total_log_count: int = 0


var current_stage: int = 0
var initial_stage = preload('res://tama/tama_0.png');
var tama_stages = [
	preload('res://tama/tama_1.png'),
	preload('res://tama/tama_2.png'),
	preload('res://tama/tama_3.png'),
	preload('res://tama/tama_4.png'),
	preload('res://tama/tama_5.png'),
	preload('res://tama/tama_6.png'),
]

func _ready():
	$Sprite.texture = initial_stage


func add_log_to_tama():
	if(total_log_count>=MAX_FILL):
		emit_signal("log_brought", total_log_count)
		return
		
	total_log_count+= 1
	emit_signal("log_brought", total_log_count)

	var logs_per_stage = float(MAX_FILL) / float(len(tama_stages))
	
	if(total_log_count >= logs_per_stage * current_stage && total_log_count<MAX_FILL):
		current_stage += 1
		$Sprite.texture = tama_stages[current_stage - 1]

	if total_log_count >= MAX_FILL:
		emit_signal("tama_built")


func _on_Node2D_area_entered(area: Area2D):
	if area.is_in_group("Player"):
		var player = area.get_parent()
		if player.picked_log != null:
			player.drop_log_to_tama()
			add_log_to_tama()
