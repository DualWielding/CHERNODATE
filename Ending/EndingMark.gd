extends Area2D

func _on_EndingMark_area_enter( area ):
	var player = area.get_parent()
	player.stop()