
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var global

func _ready():
	get_node("one_player").connect("pressed", self, "one_player")
	get_node("two_player").connect("pressed", self, "two_player")
	global = get_node("/root/global")
	
func one_player():
	global.player_count = 1
	global.goto_scene("res://scenes/main.tscn")

func two_player():
	global.player_count = 2
	global.goto_scene("res://scenes/main.tscn")
	

