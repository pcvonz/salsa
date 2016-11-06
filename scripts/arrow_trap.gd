
extends Node2D
export var arrow_speed = 1000

# member variables here, example:
# var a=2
# var b="textvar"
var ray
var arrow
var is_triggered = false
var elapsed_time = 0
func _ready():
	ray = get_node("RayCast2D")
	arrow = get_node("arrow")
	set_process(true)

func _process(delta):
	if(ray.is_colliding() and is_triggered == false and not ray.get_collider() == null and not ray.get_collider().is_in_group("static_bodies")):
		arrow.set_linear_velocity(Vector2(cos(get_rot()), sin(-get_rot()))*arrow_speed)
		arrow.set_gravity_scale(1)
		is_triggered = true
	if(is_triggered == true):
		elapsed_time += delta
		if(arrow.get_linear_velocity().length() < 200):
			if(arrow.is_in_group("enemies")):
				arrow.remove_from_group("enemies")
			if(elapsed_time > 5):
				arrow.queue_free()
				set_process(false)
			


