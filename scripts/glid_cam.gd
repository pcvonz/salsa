extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
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
	Vehicle = Vehicle.new(mass, max_speed, max_force, max_turn_rate)
	Steering = Steering.new(mass, max_speed, max_force, max_turn_rate)

func init_glide_cam(target):
	self.target = target
	set_fixed_process(true)

func update(vec_to):
	if(vec_to != target):
		print("hello")
		SteeringForce = Vector2(0, 0)
		self.target = vec_to

func _fixed_process(delta):
	SteeringForce += Steering.seek_pos(target, self)
	Vehicle.update(delta, SteeringForce, 1)
	print(Vehicle.velocity)
	set_offset(Vehicle.velocity)