
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var anim 

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("Area2D").connect("body_enter", self, "spike_up")
	anim = get_node("AnimationPlayer")
	
func spike_up(body):
	if (body.is_in_group("players")):
		anim.play("spike_up")

	pass


