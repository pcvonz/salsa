tool
extends Node2D

export(bool) var moving = false setget set_move
export(bool) var preview_movement = false setget preview_movement
export var moving_dist = 2
export var period = .5
var time_elapsed = 0
var original_pos = get_pos()
var move_to = Vector2(0,0)
var node_ref
# member variables here, example:
# var a=2
# var b="textvar"
func preview_movement(is_moving):
	if(is_moving == true):
		original_pos = get_pos()
	else:
		set_pos(original_pos)
	preview_movement = is_moving
	time_elapsed = 0
	set_fixed_process(is_moving)

func set_move(is_moving):
	if(is_moving == true):
		original_pos = get_pos()
	else:
		set_pos(original_pos)
	moving = is_moving
	time_elapsed = 0
	set_fixed_process(is_moving)
	
func _fixed_process(delta):
	time_elapsed += delta
	#Getting a null node throws a non fatal error, maybe there is a different method in Godot for checking if a node exists? 
	if moving == true and node_ref.get_ref() != null:
		if(!get_tree().is_editor_hint() or preview_movement):
			move_to = Vector2(moving_dist*sin(period * time_elapsed), moving_dist*.5*cos(period * 2 * time_elapsed))
			set_pos(get_pos() + move_to)
	else:
		set_fixed_process(false)
		
func _ready():
	set_fixed_process(true)
	node_ref =  weakref(get_node("Balloon"))
	get_node("energy").set_mode(3)


