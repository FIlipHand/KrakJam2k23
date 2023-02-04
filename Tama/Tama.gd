extends Area2D

export var MAX_FILL: int = 100
export var current_fill: int = 0

var tama_0 = preload('res://Tama/tama_0.png')
var tama_1 = preload('res://Tama/tama_1.png')
var tama_2 = preload('res://Tama/tama_2.png')
var tama_3 = preload('res://Tama/tama_3.png')

func _ready():
	$Sprite.texture = tama_0


func add_log_to_tama():
	current_fill+= 20
	if current_fill >= 20 and current_fill < 40:
		$Sprite.texture = tama_1
	if current_fill >= 40 and current_fill < 80:
		$Sprite.texture = tama_2
	if current_fill >= 80:
		$Sprite.texture = tama_3
	if current_fill >= MAX_FILL:
		print("Bjubry wygraly")


func _on_Node2D_area_entered(area: Area2D):
	if area.is_in_group("Player"):
		var player = area.get_parent()
		if player.picked_log != null:
			player.drop_log_to_tama()
			add_log_to_tama()
