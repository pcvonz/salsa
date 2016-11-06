
extends RigidBody2D

#Constants
const MAXSPEED = 600
const UP  = PI/2	#set up directional constants to avoid having to figure out pi/2 for each dir or whatever
const LEFT = PI
const RIGHT = 0
const DOWN = -PI/2

# member variables here, example:
# var a=2
# var b="textvar"

var cur_velocity
var shoot_vector = Vector2(0, -200)
var move_vector
var direction = LEFT
export var ammo = 200 
var bullet
var damage = false
var gravity_scale = 3 #Can change to make lighter/heavier based on tile

#controls
var up
var down
var right
var left
var shoot
var elapsed_time = 0

var speed_multiplier = 1
var name
var label
	
func _fixed_process(delta):
	is_contact_monitor_enabled()
	set_gravity_scale(gravity_scale)
	set_rot(direction)	##Why are we setting the rotation every loop?
	cur_velocity = get_linear_velocity()	#test for maxspeed
	if (get_linear_velocity().abs() > ((MAXSPEED * speed_multiplier) * cur_velocity.normalized()).abs()):
		set_linear_velocity((MAXSPEED*speed_multiplier) * cur_velocity.normalized());		#Hopefully should only call in 1 frame and then not call unless past maxspeed again, to avoid physics issues with multithreading
	elapsed_time += delta
	for object in get_colliding_bodies():
		if object.is_in_group('players'):
			#This bit slows down the damage taken when colliding with other players
			if elapsed_time > .2:
				add_ammo(-10)
				elapsed_time = 0
		if object.is_in_group('enemies'):
			#This is more of a placeholder for things like helicopters, etc.
			#The time counter here will probably be replaced with some kind of stun timer.
			if elapsed_time > .2:
				add_ammo(-50)
				elapsed_time = 0

	if(ammo <= 0):
		#Remove the player if they run out of ammo 
		#(eventually an animation will be played here 
		#instead and then they would queue free)
		remove_from_group("players")
		queue_free()
	
func _input(ev):
	if(Input.is_action_pressed(up)):
		shoot_vector = Vector2(0, 200)
		direction = UP
		set_rot(direction)
	if(Input.is_action_pressed(left)):
		shoot_vector = Vector2(200, 0)
		direction = LEFT
		set_rot(direction)
		
			
	if(Input.is_action_pressed(right)):
		shoot_vector = Vector2(-200, 0)
		direction = RIGHT
		set_rot(direction)
	if(Input.is_action_pressed(down)):
		shoot_vector = Vector2(0, -200)
		direction = DOWN
		set_rot(direction)
	if ev.is_action_pressed(shoot) and ammo > 0:
		var bullet_duplicate = bullet.duplicate()
		get_parent().add_child(bullet_duplicate)
		bullet_duplicate.set_global_pos(Vector2(get_node('Position2D').get_global_pos().x, get_node('Position2D').get_global_pos().y))
		apply_impulse(get_pos(), shoot_vector)
		bullet_duplicate.player_origin = get_name()
		bullet_duplicate.apply_impulse(bullet_duplicate.get_global_pos(), (-shoot_vector.normalized()*500) )
		add_ammo(-1)
		
func add_ammo(count):
	ammo += count
	label.set_text(name + ' energy: ' + str(ammo))
	
func _ready():
	set_continuous_collision_detection_mode(CCD_MODE_CAST_SHAPE)	#Slower collision detection, but more precise, which is what we want for this I think?
	if(get_name() == 'player1'):
		up = "up1"
		down = "down1"
		right = "right1"
		left = "left1"
		shoot = "shoot1"
		label = get_parent().get_node('label1')
		name = "player 1"
	else:
		up = "up2"
		down = "down2"
		right = "right2"
		left = "left2"
		shoot = "shoot2"
		label = get_parent().get_node('label2')
		name = "player 2"
	bullet = preload('res://scenes/bullet.tscn').instance()
	set_process_input(true)
	set_fixed_process(true)
	add_ammo(0)

