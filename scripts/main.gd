
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var start_pos = 100
func _ready():
	var player_count = get_node("/root/global").player_count
	var player = preload('res://scenes/player.tscn').instance()
	for i in range(0, player_count):
		var player_duplicate = player.duplicate()
		player_duplicate.set_pos(Vector2(start_pos, player_duplicate.get_pos().y))
		start_pos += 100
		call_deferred("add_child", player_duplicate)
		


