extends Node

onready var characters_node: YSort = get_node("LevelMap/Layer_3/Characters")
onready var scenePlayer: Player  = get_node("LevelMap/Layer_3/Spawn/player")

onready var startSpawn: Position2D = get_node("LevelMap/Layer_3/Spawn/Spawn")
onready var endSpawn: Position2D = get_node("LevelMap/Layer_3/Spawn/Spawn2")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
