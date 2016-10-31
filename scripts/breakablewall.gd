
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"

export var strength = 20

func _break_wall(body):
	print('hello')
	if body.is_in_group('bullets'):
		strength -= 1
		body.queue_free()
		if strength == 0:
			queue_free()

func _ready():
	connect("body_enter", self, '_break_wall')


