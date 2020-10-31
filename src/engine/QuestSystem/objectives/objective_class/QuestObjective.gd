extends Node
class_name QuestObjective

signal completed(objective)
signal updated(objective)

var _completed: bool = false

func finish() -> void:
	_completed = true
	print("Completado")
	emit_signal("completed",self)

func as_text() -> String:
	return "Objetivo %s metodo 'as_text' deberá sobreescribirse" % get_path()
