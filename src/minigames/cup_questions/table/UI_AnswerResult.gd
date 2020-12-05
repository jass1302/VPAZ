extends CanvasLayer

func _ready():
	pass
	
func setResult(_result : String):
	$"Background/VBoxContainer/ANSWER RESULT".text = _result

func _on_UI_Accept_pressed():
	queue_free()
