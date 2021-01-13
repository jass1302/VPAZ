extends CanvasLayer

onready var pipe = preload("res://minigames/pipewater_game/pipe/tipo1/pipe.tscn")
onready var pipeNode = get_node("pipes")
onready var spawnPoint: Position2D = get_node("Spawner/spawnPos")
onready var waterTemp = get_node("Water")
onready var waterTimer: Timer = get_node("waterStart")

## Tutorial
onready var tutUI = preload("res://ui/Interfaces/tutorialScreen/tutorialUI.tscn")

func _ready():
	
	if ProfileManager.tutorialsEnabled:
		var _tutUI = tutUI.instance()
		_tutUI.tutoName = "M4"
		add_child(_tutUI)
		yield(_tutUI,"tree_exited")
		
	$TimeRemaining/VBoxContainer/Label2.text = "%s segundos. " %str(int(waterTimer.time_left))

func _process(delta):
	$TimeRemaining/VBoxContainer/Label2.text = "%s segundos. " %str(int(waterTimer.time_left))

func spawnPipes() -> void:
	var _pipe =  pipe.instance()
	_pipe.connect("dropped", self, "spawnPipes")
	_pipe.position = spawnPoint.global_position
	_pipe.dropZone = spawnPoint
	_pipe.dropAux = _pipe.dropZone
	_pipe.setType()
	pipeNode.add_child(_pipe)

func _lose() -> void:
	$endGame/Panel/Results.text = "Se derramó el agua :("
	$AnimationPlayer.play("result_scrn")
	yield($AnimationPlayer,"animation_finished")
	
func _on_WinSpot_body_entered(body):
	if body is waterBody:
		$endGame/Panel/Results.text = "Bien hecho, arreglaste el flujo!"
		$AnimationPlayer.play("result_scrn")
		yield($AnimationPlayer,"animation_finished")


func _on_Start_pressed():
	$title.visible = false
	spawnPipes()
	waterTimer.start()
	$Start.visible = false


func _on_waterStart_timeout():
	waterTemp._move(Vector2(waterTemp.position.x + 50, waterTemp.position.y))
	waterTimer.stop()
