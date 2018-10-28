extends Node

func get_character():
	return get_node("Character")

func end(rads_level):
	get_node("UI/End").trigger(rads_level)