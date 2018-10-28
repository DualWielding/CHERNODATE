extends Area2D

func _on_EndingMark_area_enter( area ):
	print("oloz")
	var player = area.get_parent()
	player.stop()