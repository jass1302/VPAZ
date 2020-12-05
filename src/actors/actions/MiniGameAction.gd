extends ActionInterface

export var minigame : PackedScene


func _ready():
	pass

func action() -> void:
	playMinigame()
	emit_signal("finished")

func playMinigame():
	var game = minigame.instance()
	
	GLOBALS._game.remove_child(GLOBALS.level)
	GLOBALS.add_child(game)
	print("asfblgz")
	
