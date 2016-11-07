
extends "res://scripts/base_player.gd"

func _ready():
	set_controls("up2", "down2", "right2", "left2", "shoot2", get_node("../label2"), "player_2")
