extends Node

export var speed_affection = 0.0
export var rads_affection = 0.0
export var is_bumper = false

func _on_Area_body_enter( body ):
	body.affect_speed(speed_affection, is_bumper)
	body.affect_rads(rads_affection)