
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"
const GRAVITY = 200.0
var velocity = Vector2()

var falling = false

func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	if falling == true:
		set_pos(Vector2(get_pos().x, get_pos().y + 2))

func _on_body_enter(body):
	print("hello")
	if(body.is_in_group('bullets')):
		if get_parent().is_in_group('balloons'):
			get_parent().floating_away()
		queue_free()
	elif(body.is_in_group('players')):
		body.add_ammo(50)
		if get_parent().is_in_group('balloons'):
			get_parent().floating_away()
		queue_free()
	else:
		falling = false
	

func _ready():
	set_fixed_process(true)
	connect("body_enter", self, '_on_body_enter')


