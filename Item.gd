extends Node

export var speed_affection = 0.0
export var rads_affection = 0.0
export var is_bumper = false
export var is_destructible = true

func _ready():
	var node = get_node("AllDayLongAnim")
	if node != null:
		node.play("AllDayLong")

func destroy():
	get_node("Area").set_layer_mask_bit(1, false)
	var node = get_node("AnimationPlayer 2")
	if node == null:
		node = get_node("AnimationPlayer")
	node.play("Destroy")
	var sp = get_node("SamplePlayer")
	if sp != null:
		sp.play("Sound")

func _on_Area_area_enter( area ):
	var body = area.get_parent()
	body.affect_speed(speed_affection, is_bumper)
	body.affect_rads(rads_affection)
	if is_destructible:
		destroy()