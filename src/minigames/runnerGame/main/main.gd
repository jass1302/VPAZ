extends CanvasLayer

onready var spawner = get_node("SpawnObst")
onready var player = preload("res://minigames/runnerGame/player/Perrito.tscn")
onready var spawn = get_node("Spawn")

var score: int = 0
var gameEnded: bool = false
export var winValue: int = 50

onready var tutUI = preload("res://ui/Interfaces/tutorialScreen/tutorialUI.tscn")

func _ready():
	GLOBALS.initVolumeAudio()
	if ProfileManager.tutorialsEnabled:
		var _tutUI = tutUI.instance()
		_tutUI.tutoName = "M10"
		add_child(_tutUI)
		yield(_tutUI,"tree_exited")
	$Score/Objective.text = "¡Esquiva los obstaculos y junta %s puntos para ganar!" %winValue
	spawner.connect("obs_created", self, "_connectObstacle")

func _on_Start_pressed():
	$Score.visible = true
	$Start.visible = false
	spawner.start()
	instaceNewPlayer()
	$Spawn2.visible = true
	$Spawn2/Tractor/AudioStreamPlayer2D.play()
	$AnimationPlayer.play("enterTruck")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("backgroundAnimation")

func instaceNewPlayer() -> void:
	var _player = player.instance()
	spawn.add_child(_player)

func _on_Salir_pressed():
	pass # Replace with function body.

func _connectObstacle(obs: obsRunner) -> void:
	obs.connect("scoreUP", self, "_scoreUp")
	obs.connect("lose", self, "loseMethod")

func resultScrn(won: bool):
	if won:
		$endGame/Panel/Results.text = "¡Juego completado!"
		$endGame/Panel/Puntos.text = "Juntaste los puntos necesarios para ganar"
		$endGame/Panel/Puntos.visible = true
		$endGame/Panel/Button.visible = true
		$endGame/Panel/Button.text = "Jugar de nuevo"

		$endGame/Panel/Button2.text = "Continuar"
		$endGame/Panel/Button2.visible = true
	else:
		$endGame/Panel/Results.text = "¡Mala suerte!"
		$endGame/Panel/Puntos.text = "Te faltaron %s puntos para ganar." %str(winValue-score)
		$endGame/Panel/Puntos.visible = true
		$endGame/Panel/Button.visible = true
		$endGame/Panel/Button.text = "Salir"
		$endGame/Panel/Button2.visible = true
		$endGame/Panel/Button2.text = "Reintentar"

	$AnimationPlayer.play("result_scrn")
	yield($AnimationPlayer,"animation_finished")

func _scoreUp() -> void:
	if not gameEnded:
		score +=1
		$Score/Points.text = str(score)
		if score == winValue:
			yield(get_tree().create_timer(0.4),"timeout")
			cleanScrn(null)
			resultScrn(true)

func cleanScrn(player) -> void:
	spawner.stop()
	$Spawn2.visible = false
	$Score.visible = false
	yield(get_tree().create_timer(1),"timeout")
	if player != null:
		player.queue_free()
	else:
		player = get_tree().get_nodes_in_group("runnerPlayer")[0]
		player.queue_free()
	
func loseMethod() -> void:
	gameEnded = true
	var player = get_tree().get_nodes_in_group("runnerPlayer")[0]
	player.lose()
	yield(get_tree().create_timer(0.6),"timeout")
	cleanScrn(player)
	resultScrn(false)

func retry() -> void:
	$AnimationPlayer.play("result_scrn_out")
	yield($AnimationPlayer,"animation_finished")
	gameEnded = false
	score = 0
	$Score/Points.text = str(score)
	$Score.visible = true
	instaceNewPlayer()
	spawner.start()
	$Spawn2.visible = true
	$AnimationPlayer.play("enterTruck")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("backgroundAnimation")
	
func quit() -> void:
	$AnimationPlayer.play("result_scrn_out")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("fadeOut")
	yield($AnimationPlayer,"animation_finished")
	queue_free()

func _on_Button_pressed():
	if $endGame/Panel/Button.text == "Jugar de nuevo":
		retry()
	if $endGame/Panel/Button.text == "Salir":
		quit()

func _on_Button2_pressed():
	if $endGame/Panel/Button2.text == "Reintentar":
		retry()
	if $endGame/Panel/Button2.text == "Continuar":
		quit()
