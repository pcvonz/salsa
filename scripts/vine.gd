
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"
export var speed = .2
func slow_down(body):
	if(body.is_in_group("players") or body.is_in_group("enemies")):
		body.speed_multiplier = speed

func remove_slow(body):
	if(body.is_in_group("players") or body.is_in_group("enemies")):
		body.speed_multiplier = speed

func _ready():
	connect("body_enter", self, "slow_down")
	connect("body_exit", self, "remove_slow")

