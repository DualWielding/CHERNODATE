extends Sprite

var rad_goal = 0

func set_value(value):
	# value is in %
	rad_goal =  value

func _ready():
	set_process(true)

func _process(delta):
	#set_pos(Vector2(450 + rad_goal*4, get_pos().y))
	var p = (get_pos().x - 450) / 4
	var m =  abs(p - rad_goal)
	if m < 5:
		m = 5
	if p > 0 and p > rad_goal:
		set_pos(Vector2(get_pos().x - delta * m, get_pos().y))
	elif p < 100 and p < rad_goal:
		set_pos(Vector2(get_pos().x + delta * m, get_pos().y))
	#if rad_goal > get_rot():
	#	set_rot(get_rot() + delta/2.5)
	#elif rad_goal < get_rot():
	#	set_rot(get_rot() - delta/2.5)
	#if abs(get_rot() - rad_goal) < 0.15:
	#	randomize()
	#	var al_val = rand_range(5, 8)
	#	if rand_range(-1, 1) < 0:
	#		al_val *= -1
	#	rad_goal = -(((rad_goal + al_val) / 100 * PI) - PI/2)