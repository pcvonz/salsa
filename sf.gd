
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var shoot_vector = Vector2(0, -200)
var direction = PI
var ammo = 200
func _fixed_process(delta):
	set_rot(direction)

func _input(ev):
	if(Input.is_action_pressed("ui_up")):
		shoot_vector = Vector2(0, 200)
		direction = PI/2
	if(Input.is_action_pressed("ui_left")):
		shoot_vector = Vector2(200, 0)
		direction = PI
	if(Input.is_action_pressed("ui_right")):
		shoot_vector = Vector2(-200, 0)
		direction = 0
	if(Input.is_action_pressed("ui_down")):
		shoot_vector = Vector2(0, -200)
		direction = -PI/2
	if ev.is_action_pressed("shoot") and ammo > 0:
		print('hello')
		apply_impulse(get_pos(), shoot_vector)
	ammo -= 1
	
func _ready():
	set_process_input(true)
	set_fixed_process(true)

