extends Node
onready var parent: Node2D
onready var level: Node2D = get_node("LevelMap")
onready var player: Player = get_node("LevelMap/Layer 3/Characters/Jugador")
func _ready():
	if SAVESYS.load_game(name):
		player.queue_free()
	else:
		player.position = Vector2(0,0)
