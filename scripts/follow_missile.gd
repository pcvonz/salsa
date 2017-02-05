
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

#If true, the enemy will not die when other bodies enter it's collisionshape
export var immortal = false

#if true the enemy will die when a bullet enters it's collision shape
export var die_on_bullet = false

var speed_multiplier = 1

func set_speed_multiplier(new_multiplier):
	speed_multiplier = new_multiplier

func _ready():
	set_fixed_process(true)
	Vehicle = Vehicle.new(mass, max_speed, max_force, max_turn_rate)
	Steering = Steering.new(mass, max_speed, max_force, max_turn_rate)
	connect("body_enter", self, "on_body_enter")
	#It was really fun to have the enemies all die by colliding,
	#But that made it so that bullets wouldn't register sometimes
	#because when the follow enemies are in swarms, they're all colliding.
	#So it was easier to just remove and then add the collision back
	for i in get_tree().get_nodes_in_group("follow_enemies"):
		add_collision_exception_with(i)

func on_body_enter(body):
	if immortal == false:
		queue_free()
	elif(die_on_bullet == true):
		if(body.is_in_group("bullets")):

			if(body.get_linear_velocity().length() > 100):
				#Remove collision exception
				for i in get_tree().get_nodes_in_group("follow_enemies"):
					remove_collision_exception_with(i)
				get_node("CollisionShape2D").set_trigger(false)
				set_linear_velocity(body.get_linear_velocity())
				set_fixed_process(false)
				add_collision_exception_with(get_node("../player1"))
				remove_from_group("enemies")
				add_to_group("bullets")


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
		if(players.size() > 0 and get_global_pos().distance_to(target.get_global_pos()) < 200):
			SteeringForce += Steering.seek(target, self)
			Vehicle.update(delta, SteeringForce, speed_multiplier)
			look_at(get_global_pos() - get_linear_velocity().normalized())
			set_linear_velocity(Vehicle.velocity)
		else:
			set_gravity_scale(0)
	else:
		get_node("CollisionShape2D").set_trigger(false)

	