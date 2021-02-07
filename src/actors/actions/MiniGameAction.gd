extends ActionInterface
class_name minigame_action

export var minigame : PackedScene

func action() -> void:
	for x in get_tree().get_nodes_in_group("main_BGM"):
		x.stop()
	GLOBALS.TRANSITION()
	yield(get_tree().create_timer(1.1),"timeout")
	var _minigame = minigame.instance()
	add_child(_minigame)
	yield(_minigame,"tree_exited")
	emit_signal("finished")
	for x in get_tree().get_nodes_in_group("main_BGM"):
		x.play()
