extends Node2D

## Banderas para botón de acción
var canActionButton : bool = false
var isActionButton : bool = false
onready var overPlayer : Player = preload("res://actors/player/player.tscn").instance()
var currentAction : String = ""
onready var transition_ani : PackedScene = preload("res://engine/TransitionScenes/TransitionScreen.tscn")


func hide_ui():
	get_tree().get_nodes_in_group("general_user_interface")[0].visible = false

func show_ui():
	get_tree().get_nodes_in_group("general_user_interface")[0].visible = true

func TRANSITION() -> void:
	var _transition = transition_ani.instance()
	add_child(_transition)
	_transition.transition()
