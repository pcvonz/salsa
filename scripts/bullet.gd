
extends RigidBody2D
var player_origin

func _fixed_process(delta):
	for object in get_colliding_bodies():
		if object.get_type() == 'StaticBody2D':
			queue_free()
		if object.is_in_group('players') and object.get_name() != player_origin:
			object.add_ammo(-20)
			queue_free()

func _ready():
	set_fixed_process(true)


