tool
extends Area2D

export(bool) var moving = false setget set_move
export var moving_dist = 2
export var period = .5
var time_elapsed = 0
var floating_away = false
var original_pos = get_pos()


func set_move(is_moving):
	if(is_moving == true):
		original_pos = get_pos()
	else:
		set_pos(original_pos)
	moving = is_moving
	time_elapsed = 0
	set_fixed_process(is_moving)

func _ready():
	set_fixed_process(true)
	if !(get_tree().is_editor_hint()):
		connect("body_enter", self, "drop_energy")

func floating_away():
	floating_away = true

func _fixed_process(delta):
	#If process is set to true, then balloon floats away
	if(floating_away == true):
		set_pos(Vector2(get_pos().x, get_pos().y - 2))
	time_elapsed += delta
	if moving == true:
		var move_to = Vector2(moving_dist*sin(period * time_elapsed), 0)
		set_pos(get_pos() + move_to)
		

func drop_energy(body):
	get_node('Sprite').queue_free()
	get_node('CollisionShape2D').queue_free()
	#Probably a better way to do this would be to use a rigid body that is
	#pinned to the balloon string.
	if(get_node('energy')):
		get_node('energy').falling = true



