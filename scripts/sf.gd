
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var shoot_vector = Vector2(0, -200)
var direction = PI
export var ammo = 200 
var bullet
var damage = false

#controls
var up
var down
var right
var left
var shoot
var elapsed_time = 0

var label
func check_static_collide():
	for object in get_colliding_bodies():
		if object.get_type() == 'StaticBody2D':
			return true	
	return false
	
func _fixed_process(delta):
	set_rot(direction)
	elapsed_time += delta
	for object in get_colliding_bodies():
		if object.is_in_group('players'):
			if elapsed_time > .2:
				add_ammo(-10)
				elapsed_time = 0
	if check_static_collide() and Input.is_action_pressed(right):
		set_pos(Vector2(get_pos().x + 2, get_pos().y))
	if check_static_collide() and Input.is_action_pressed(left):
		set_pos(Vector2(get_pos().x - 2, get_pos().y))
	
func _input(ev):
	if(Input.is_action_pressed(up)):
		shoot_vector = Vector2(0, 200)
		direction = PI/2
		set_rot(direction)
	if(Input.is_action_pressed(left)):
		shoot_vector = Vector2(200, 0)
		direction = PI
		set_rot(direction)
		
			
	if(Input.is_action_pressed(right)):
		shoot_vector = Vector2(-200, 0)
		direction = 0
		set_rot(direction)
	if(Input.is_action_pressed(down)):
		shoot_vector = Vector2(0, -200)
		direction = -PI/2
		set_rot(direction)
	if ev.is_action_pressed(shoot) and ammo > 0:
		var bullet_duplicate = bullet.duplicate()
		get_parent().add_child(bullet_duplicate)
		bullet_duplicate.set_global_pos(Vector2(get_node('Position2D').get_global_pos().x, get_node('Position2D').get_global_pos().y))
		apply_impulse(get_pos(), shoot_vector)
		bullet_duplicate.player_origin = get_name()
		bullet_duplicate.apply_impulse(bullet_duplicate.get_global_pos(), (-shoot_vector.normalized()*1500) )
		add_ammo(-1)
		
func add_ammo(count):
	ammo += count
	label.set_text(get_name() + ' energy: ' + str(ammo))
	
func _ready():
	if(get_name() == 'player1'):
		up = "up1"
		down = "down1"
		right = "right1"
		left = "left1"
		shoot = "shoot1"
		label = get_parent().get_node('label1')
	else:
		up = "up2"
		down = "down2"
		right = "right2"
		left = "left2"
		shoot = "shoot2"
		label = get_parent().get_node('label2')
	bullet = preload('res://scenes/bullet.tscn').instance()
	set_process_input(true)
	set_fixed_process(true)
	add_ammo(0)

