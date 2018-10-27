extends Node

export var speed_affection = 0.0
export var rads_affection = 0.0

func _on_Area_body_enter( body ):
	body.affect_speed(speed_affection)
	body.affect_rads(rads_affection)
	print("lolz")