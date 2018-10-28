extends Node2D

func activate():
	show()
	var ap = get_node("AnimationPlayer")
	ap.play("Pop")
	ap.connect("finished", self, "_wriggle")

func _wriggle():
	get_node("AnimationPlayer").play("Wriggle")

func deactivate():
	hide()
	get_node("AnimationPlayer").stop_all()