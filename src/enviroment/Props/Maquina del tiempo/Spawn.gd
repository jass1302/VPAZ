extends YSort
export var level: String

func _ready():
	GLOBALS.overPlayer = GLOBALS.player.instance()
	add_child(GLOBALS.overPlayer)
	GLOBALS.overPlayer.position = $Spawn.position
	GLOBALS.overPlayer.moving = true
	GLOBALS.overPlayer.destination = $Spawn2.position
	yield(get_tree().create_timer(1),"timeout")
	$TimeMachine._activateMachine()
	GLOBALS.show_ui()
