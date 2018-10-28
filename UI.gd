extends CanvasLayer

var character
var time_between_geiger_update = 1
var timer = 0

func _ready():
	character = get_parent().get_character()
	set_process(true)

func _process(delta):
	get_node("Speed").set_text(str("SPEED : ", character.get_speed()))
	timer += delta
	if timer >= time_between_geiger_update:
		timer = 0
		get_node("Radsbar").set_value(character.get_rads())