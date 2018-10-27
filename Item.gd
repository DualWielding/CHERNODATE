extends Node

export var speed_affection = 0.0
export var rads_affection = 0.0
export var is_bumper = false
export var is_destructible = true

func destroy():
	get_node("AnimationPlayer").play("Destroy")

func _on_Area_area_enter( area ):
	var body = area.get_parent()
	body.affect_speed(speed_affection, is_bumper)
	body.affect_rads(rads_affection)
	if is_destructible:
		destroy()