extends Sprite

var rad_goal

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