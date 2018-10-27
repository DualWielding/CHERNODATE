extends Sprite

func activate():
	show()
	get_node("AnimationPlayer").play("Wriggle")

func deactivate():
	hide()
	get_node("AnimationPlayer").stop_all()