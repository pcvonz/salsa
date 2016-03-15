
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"
func body_enter(body):
	print('no')
	if(body.get_name() == "player1"):
		print('why')
		body.damage = true

func stop_damage_player(body):
	if(body.get_name() == "player1"):
		body.damage = false

func _ready():
	connect("body_enter", self, "damgage_player")
	connect("body_exit", self, "stop_damage_player")


