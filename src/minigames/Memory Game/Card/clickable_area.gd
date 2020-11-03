extends Area2D

## En este script vamos a revisar si la carta es "tocada"


signal clicked

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouse:
		if event.is_pressed() && event.button_index == BUTTON_LEFT:
			emit_signal("clicked")  
