extends Node2D

## Banderas para botón de acción
var canActionButton : bool = false
var isActionButton : bool = false
onready var player: PackedScene = preload("res://actors/player/player.tscn")
onready var overPlayer : Player

var currentAction : String = ""
onready var transition_ani : PackedScene = preload("res://engine/TransitionScenes/TransitionScreen.tscn")

func _process(delta):
	if Input.is_action_just_pressed("save"):
		pass

func hide_ui():
	get_tree().get_nodes_in_group("general_user_interface")[0].visible = false

func show_ui():
	get_tree().get_nodes_in_group("general_user_interface")[0].visible = true

func TRANSITION() -> void:
	var _transition = transition_ani.instance()
	add_child(_transition)
	_transition.transition()

func initVolumeAudio() -> void:
	for bgm in get_tree().get_nodes_in_group("BGM"):
		bgm.volume_db = ProfileManager.BGMVolume
	for sfx in get_tree().get_nodes_in_group("SFX"):
		sfx.volume_db = ProfileManager.SFXVolume

