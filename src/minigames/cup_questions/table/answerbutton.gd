extends Button

var isCorrect: bool
var answerText: String
onready var rMessage = preload("res://minigames/cup_questions/table/UI_AnswerResult.tscn")

signal answered(answer)


func _on_ans_1_pressed():
	var _rMessage = rMessage.instance()
	if isCorrect:
		_rMessage.setResult("¡Respuesta correcta! :)")
	else:
		_rMessage.setResult("¡Respuesta incorrecta! :(")

	add_child(_rMessage)
	yield(_rMessage,"tree_exiting")
	emit_signal("answered",isCorrect)
