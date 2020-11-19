extends Node2D

## Banderas para botón de acción
var canActionButton : bool = false
var isActionButton : bool = false
var currentAction : String = ""
onready var user_interface = preload("res://ui/UI.tscn/").instance()

func hide_ui():
	user_interface.hide_ui()

func show_ui():
	user_interface.show_ui()
