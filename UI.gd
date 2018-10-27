extends CanvasLayer

var character

func _ready():
	character = get_parent().get_character()
	set_process(true)

func _process(delta):
	get_node("Speed").set_text(str("SPEED : ", character.get_speed()))
	get_node("Radsbar").set_value(character.get_rads())