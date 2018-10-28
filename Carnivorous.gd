extends Node2D

func activate():
	get_node("AnimationPlayer").play("Pop")

func deactivate():
	get_node("AnimationPlayer").play_backwards("Pop")