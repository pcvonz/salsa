
extends "res://scripts/base_player.gd"

func _ready():
	set_controls("up1", "down1", "right1", "left1", "shoot1", get_node("../label1"), "player_1")
	