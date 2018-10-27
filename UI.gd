extends CanvasLayer

var character

func _ready():
	character = get_parent().get_character()
	set_process(true)

func _process(delta):
	get_node("Rads").set_text(str("RADS : ", character.get_rads()))
	get_node("Speed").set_text(str("SPEED : ", character.get_speed()))