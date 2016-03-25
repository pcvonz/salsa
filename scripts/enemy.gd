
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"
func floating_away():
	set_process(true)

func _process(delta):
	set_pos(Vector2(get_pos().x, get_pos().y - 2))

func drop_energy(body):
	get_node('Sprite').queue_free()
	get_node('CollisionShape2D').queue_free()
	if(get_node('energy')):
		get_node('energy').falling = true

func _ready():
	connect("body_enter", self, "drop_energy")


