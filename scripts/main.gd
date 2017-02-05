
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var start_pos = 100
var player
var node_ref
func _ready():
#	var player_count = get_node("/root/global").player_count
#	var player_1 = preload('res://scenes/player1.tscn').instance()
#	
#	player_1._init("up1", "down1", "right1", "left1", "shoot1", get_node("label1"), "player 1")
#	var player_2 = preload('res://scenes/player2.tscn').instance()
#	player_2.init("up2", "down2", "right2", "left2", "shoot2", get_node("label2"), "player 1")\
#	player_1.set_name("player_1")

#	add_child(player_1)
#	player_1.set_global_pos(get_node("player1_start").get_global_pos())
#	if(player_count == 2):
#		player_2.set_name("player_2")
#		add_child(player_2)
#		player_2.set_global_pos(get_node("player2_start").get_global_pos())
#		
	set_process(true)
	player = get_node("player1")
	node_ref =  weakref(player)
	

func _process(delta):
	#Win condition is all energy tanks have been picked up
	#All energy tanks are in the group "energy"
	if(node_ref.get_ref() != null):	
		get_node("Light2D").set_pos(get_node("player1").get_pos())
	if(get_tree().get_nodes_in_group("energy").size() <= 0):
		print("level_complete")