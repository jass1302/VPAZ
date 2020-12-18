extends Node
class_name QuestObjective

signal completed(objective)
signal updated(objective)

var _completed: bool = false

func finish() -> void:
	_completed = true
	emit_signal("completed", self)
	print("MiniGame_Completed")

func as_text() -> String:
	return "OLVIDASTE SOBREESCRIBIR EL METODO as_text."
