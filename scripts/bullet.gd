 
extends RigidBody2D
var player_origin

#func _fixed_process(delta):
#	for object in get_colliding_bodies():
#		if object.is_in_group('players') and object.get_name() != player_origin:
#			object.add_ammo(-20)
#		queue_free()

func bullet_hit(body):
	if body.is_in_group('players') and body.get_name() != player_origin:
		body.add_ammo(-20)
	self.queue_free()

func _ready():
	connect("body_enter", self, "bullet_hit")
	#set_fixed_process(true)


