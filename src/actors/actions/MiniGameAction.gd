extends ActionInterface
class_name minigame_action

export (String, FILE, "*.tscn") var minigame : String
export var test : PackedScene

func action() -> void:
	var _test = test.instance()
	get_tree().paused = false
	add_child(_test)
	yield(_test,"tree_exited")
	emit_signal("finished")
