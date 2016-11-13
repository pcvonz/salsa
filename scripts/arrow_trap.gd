
extends Node2D
export var arrow_speed = 1000

# member variables here, example:
# var a=2
# var b="textvar"
var ray
var arrow
var is_triggered = false
var elapsed_time = 0
export var persistent = true
var speed_multiplier = 1

func _ready():
	ray = get_node("RayCast2D")
	arrow = get_node("arrow")
	set_fixed_process(true)

func set_speed_multiplier(multiplier):
	speed_multiplier = multiplier

func _fixed_process(delta):
	if(ray.is_colliding() and is_triggered == false and not ray.get_collider() == null and not ray.get_collider().is_in_group("static_bodies")):
		arrow.set_linear_velocity(Vector2(cos(get_rot()), sin(-get_rot()))*arrow_speed)
		arrow.set_gravity_scale(1)
		is_triggered = true
	print(arrow.get_rot())
	if(is_triggered == true):
		elapsed_time += delta
		if(arrow.get_linear_velocity().length() < 200):
			if(arrow.is_in_group("enemies")):
				arrow.remove_from_group("enemies")
			if(persistent == false):
				if(elapsed_time > 5):
					arrow.queue_free()
					set_process(false)
		if(arrow.get_colliding_bodies().size() > 0 and not arrow.get_colliding_bodies()[0].is_in_group("arrows")):
			var col = arrow.get_colliding_bodies()[0]
			var new_arrow = arrow.duplicate()
			var arrow_pos = arrow.get_global_pos()
			var arrow_rot = arrow.get_global_transform()
			arrow.queue_free()
			col.add_child(new_arrow)
			new_arrow.set_global_pos(arrow_pos)
			new_arrow.set_global_transform(arrow_rot)
			new_arrow.add_collision_exception_with(col)
			new_arrow.set_mode(3)
			new_arrow.remove_from_group("enemies")
			print(arrow.get_colliding_bodies()[0])
			print(arrow.get_colliding_bodies()[0].get_children())
			set_fixed_process(false)
					
			
			


