extends Node
class_name ActionInterface

signal finished
var active: bool = true

func action() -> void:
	print("Debes sobreescribir esta función")
	emit_signal("finished")
