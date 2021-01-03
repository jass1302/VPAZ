extends TextureButton

var isHere: bool = false
signal buttonPressed(isCorrect)

func _on_frameButton_pressed():
	if isHere:
		$AnimationPlayer.play("correct")
		emit_signal("buttonPressed", true)
	else:
		$AnimationPlayer.play("incorrect")
		emit_signal("buttonPressed", false)
