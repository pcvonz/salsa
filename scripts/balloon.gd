extends Area2D

var floating_away = false

func _ready():
	set_fixed_process(true)
	connect("body_enter", self, "drop_energy")

func floating_away():
	floating_away = true

func _fixed_process(delta):
	#If process is set to true, then balloon floats away
	if(!get_parent().has_node("energy")):
		floating_away = true
	if(floating_away == true):
		set_pos(Vector2(get_pos().x, get_pos().y - 2))

func drop_energy(body):
	if(get_parent().has_node("energy")):
		get_node("../energy").set_mode(0)
		#This makes it continue moving in the direction the balloon was moving. 
		#Kind of hacky, but semi realistic looking?
		#I don't know I'm not good at math - Paul
		get_node("../energy").apply_impulse(get_node("../energy").get_pos(), get_parent().move_to * get_parent().moving_dist * get_parent().period )
	queue_free()
	
	



