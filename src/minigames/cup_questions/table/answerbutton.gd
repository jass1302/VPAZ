extends Button

var isCorrect: bool
var answerText: String
onready var rMessage = preload("res://minigames/cup_questions/table/UI_AnswerResult.tscn")

signal answered(answer)


func _on_ans_1_pressed():
	var _rMessage = rMessage.instance()
	if isCorrect:
		_rMessage.setResult("¡Respuesta correcta! :)", true)
	else:
		_rMessage.setResult("¡Respuesta incorrecta! :(", false)

	add_child(_rMessage)
	yield(_rMessage,"tree_exiting")
	emit_signal("answered",isCorrect)

func playAnimation() -> void:
	$AniBu.play("Enter_Button")
	yield($AniBu,"animation_finished")
