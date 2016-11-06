
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _on_body_enter(body):
	print("hello")
	if(body.is_in_group('bullets') or body.is_in_group("enemies")):
		if get_parent().is_in_group('balloons'):
			get_parent().floating_away()
		queue_free()
	elif(body.is_in_group('players')):
		body.add_ammo(50)
		if get_parent().is_in_group('balloons'):
			get_parent().floating_away()
		queue_free()

func _ready():
	set_fixed_process(true)
	connect("body_enter", self, '_on_body_enter')


