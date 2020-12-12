extends Node2D

## Banderas para botón de acción
var canActionButton : bool = false
var isActionButton : bool = false
var overPlayer : Player
var currentAction : String = ""
onready var transition_ani : PackedScene = preload("res://engine/TransitionScenes/TransitionScreen.tscn")


func hide_ui():
	get_tree().get_nodes_in_group("general_user_interface")[0].visible = false

func show_ui():
	get_tree().get_nodes_in_group("general_user_interface")[0].visible = true

func TRANSITION(destination: String) -> void:
	var _transition = transition_ani.instance()
	add_child(_transition)
	_transition.transition()
	yield(get_tree().create_timer(1),"timeout")
	get_tree().paused = false
	get_tree().change_scene(destination)

