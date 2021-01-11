extends CanvasLayer

onready var pipe = preload("res://minigames/pipewater_game/pipe/tipo1/pipe.tscn")
onready var spawnPoint: Position2D = get_node("Spawner/spawnPos")
onready var waterTemp = get_node("Water")
func _ready():
	spawnPipes()


func spawnPipes() -> void:
	var _pipe =  pipe.instance()
	_pipe.connect("dropped", self, "spawnPipes")
	_pipe.position = spawnPoint.global_position
	_pipe.dropZone = spawnPoint
	_pipe.dropAux = _pipe.dropZone
	_pipe.setType()
	add_child(_pipe)
	print(spawnPoint.position)
	print(_pipe.position)


func _on_GoWater_pressed():
	waterTemp._move(Vector2(waterTemp.position.x + 50, waterTemp.position.y))
