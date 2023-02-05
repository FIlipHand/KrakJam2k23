extends Area2D

signal log_brought(total_logs_count)
signal tama_built()

export var MAX_FILL: int = 100
export var total_log_count: int = 0

var tama_0 = preload('res://Tama/tama_0.png')
var tama_1 = preload('res://Tama/tama_1.png')
var tama_2 = preload('res://Tama/tama_2.png')
var tama_3 = preload('res://Tama/tama_3.png')

func _ready():
	$Sprite.texture = tama_0


func add_log_to_tama():
	total_log_count+= 1
	if total_log_count >= 1 and total_log_count < 3:
		$Sprite.texture = tama_1
	if total_log_count >= 3 and total_log_count < 5:
		$Sprite.texture = tama_2
	if total_log_count >= 10:
		$Sprite.texture = tama_3
	if total_log_count >= MAX_FILL:
		emit_signal("tama_built")
	emit_signal("log_brought", total_log_count)


func _on_Node2D_area_entered(area: Area2D):
	if area.is_in_group("Player"):
		var player = area.get_parent()
		if player.picked_log != null:
			player.drop_log_to_tama()
			add_log_to_tama()
