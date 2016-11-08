
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"

export var strength = 1

func _break_wall(body):
	print('shot wall')
	if body.is_in_group('bullets'):
		strength -= 1
		if strength == 0:
			body.queue_free()
			queue_free()

func _ready():
	connect("body_enter", self, '_break_wall')


