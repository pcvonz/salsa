
extends Area2D

func floating_away():
	set_fixed_process(true)

func _fixed_process(delta):
	#If process is set to true, then balloon floats away
	set_pos(Vector2(get_pos().x, get_pos().y - 2))

func drop_energy(body):
	get_node('Sprite').queue_free()
	get_node('CollisionShape2D').queue_free()
	#Probably a better way to do this would be to use a rigid body that is
	#pinned to the balloon string.
	if(get_node('energy')):
		get_node('energy').falling = true

func _ready():
	connect("body_enter", self, "drop_energy")


