
extends RigidBody2D

var Vehicle = load("res://scripts/Vehicle.gd")
var Steering = load("res://scripts/steering.gd")

var SteeringForce = Vector2(0,0)
var target
var players = []
var player_index = 0
export var max_speed = 1.0
export var mass = 50.0
export var max_force = 1.0
export var max_turn_rate = 1.0

func _ready():
	set_fixed_process(true)
	Vehicle = Vehicle.new(mass, max_speed, max_force, max_turn_rate)
	Steering = Steering.new(mass, max_speed, max_force, max_turn_rate)

func find_closest_player(players):
	for i in range(0, players.size()):
		var node_ref =  weakref(players[i])
		if(node_ref.get_ref() != null):
			if players[i].get_pos().distance_to(get_pos()) < players[player_index].get_pos().distance_to(get_pos()):
				player_index = i

func _fixed_process(delta):
	print(players)
	players = get_tree().get_nodes_in_group("players")
	if(players.size() > 0):
		var node_ref =  weakref(players[player_index])
		if node_ref.get_ref() != null:
			find_closest_player(players)
		else:
			players.remove(player_index)
			find_closest_player(players)
		if(players.size() > 0):
			SteeringForce += Steering.seek(players[player_index], self)
			Vehicle.update(delta, SteeringForce)
			set_linear_velocity(Vehicle.velocity)