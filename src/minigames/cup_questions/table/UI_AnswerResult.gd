extends CanvasLayer

func _ready():
	pass
	
func setResult(_result : String, _ans : bool):
	if _ans:
		$Background.color = Color(0.08,0.51,0.07)
	else:
		$Background.color = Color(0.82,0.19,0.19)
	$"Background/VBoxContainer/ANSWER RESULT".text = _result
	$AnimationPlayer.play("enter_text")
	yield($AnimationPlayer,"animation_finished")

func _on_Continue_pressed():
	queue_free()
