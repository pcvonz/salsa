
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var shoot_vector = Vector2(0, -200)
var direction = PI
var ammo = 200
var bullet
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
		var bullet_duplicate = bullet.duplicate()
		get_parent().add_child(bullet_duplicate)
		bullet_duplicate.set_global_pos(Vector2(get_node('Position2D').get_global_pos().x, get_node('Position2D').get_global_pos().y))
		apply_impulse(get_pos(), shoot_vector)
		bullet_duplicate.apply_impulse(bullet_duplicate.get_global_pos(), -shoot_vector.normalized()*800)
	ammo -= 1
	
func _ready():
	bullet = preload('res://bullet.tscn').instance()
	set_process_input(true)
	set_fixed_process(true)

