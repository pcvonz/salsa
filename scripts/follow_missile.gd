
extends RigidBody2D

var Vehicle = load("res://scripts/Vehicle.gd")
var Steering = load("res://scripts/steering.gd")

var SteeringForce = Vector2(0,0)
var target
var players = []
export var max_speed = 1.0
export var mass = 50.0 
export var max_force = 1.0
export var max_turn_rate = 1.0

func _ready():
	set_fixed_process(true)
	Vehicle = Vehicle.new(mass, max_speed, max_force, max_turn_rate)
	Steering = Steering.new(mass, max_speed, max_force, max_turn_rate)

func find_closest_player():
	for i in players:
		var node_ref =  weakref(target)
		if(node_ref.get_ref() != null):
			if i.get_pos().distance_to(get_pos()) < target.get_pos().distance_to(get_pos()):
				target = i

func _fixed_process(delta):
	players = get_tree().get_nodes_in_group("players")
	if not players.empty():
		target = players[0]
		var node_ref =  weakref(target)
		if node_ref.get_ref() != null:
			find_closest_player()
		if(players.size() > 0):
			SteeringForce += Steering.seek(target, self)
			Vehicle.update(delta, SteeringForce)
			set_linear_velocity(Vehicle.velocity)

	