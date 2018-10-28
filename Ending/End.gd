extends Control

const WAIT_TIME_FOR_DIALOG = 0.7
var ending

func trigger(rads_level):
	get_node("ColorFrame").show()
	if rads_level <= 33.0:
		ending = get_node("Good")
	elif rads_level <= 66.0:
		ending = get_node("Meh")
	else:
		ending = get_node("Bad")
	ending.show()
	var t = Timer.new()
	t.set_wait_time(WAIT_TIME_FOR_DIALOG)
	t.connect("timeout", self, "pop_button")
	add_child(t)
	t.set_one_shot(true)
	t.start()

func pop_button():
	get_node("Button").show()

func _on_Button_pressed():
	get_tree().quit()
