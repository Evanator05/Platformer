extends MarginContainer

func _process(delta):
	$HBoxContainer/VBoxContainer/FPS_COUNTER.text = "FPS: " + str(Performance.get_monitor(Performance.TIME_FPS))
	pass
