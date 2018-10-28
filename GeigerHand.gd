extends Sprite

var rad_goal = 0

func set_value(value):
	# value is in %
	rad_goal =  -((value / 100 * PI) - PI/2)

func _ready():
	set_process(true)

func _process(delta):
	if rad_goal > get_rot():
		set_rot(get_rot() + delta/2.5)
	elif rad_goal < get_rot():
		set_rot(get_rot() - delta/2.5)
	if abs(get_rot() - rad_goal) < 0.15:
		randomize()
		var al_val = rand_range(5, 8)
		if rand_range(-1, 1) < 0:
			al_val *= -1
		rad_goal = -(((rad_goal + al_val) / 100 * PI) - PI/2)