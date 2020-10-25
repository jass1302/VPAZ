extends CanvasLayer

func _physics_process(delta):
	$MarginContainer/HBoxContainer/VBoxContainer/FPS.text = "FPS: " + str(Performance.get_monitor(Performance.TIME_FPS))
	$MarginContainer/HBoxContainer/VBoxContainer/MEMORY.text = "Memory: " + str(round(Performance.get_monitor(Performance.MEMORY_STATIC)/1024/1024))
