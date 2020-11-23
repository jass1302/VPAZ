extends Node
class_name ActionInterface

signal finished
var active: bool = true
var game

func _initialize(_game):
	game = _game
	
func action() -> void:
	print("Debes sobreescribir esta función")
	emit_signal("finished")
