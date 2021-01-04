extends CanvasLayer

onready var ObstSpawner = $ObstSpawner
onready var Eagle = $Eagle
onready var Score = $Score
onready var ground  = $Ground
var won: bool = false

func _ready():
	$Objective.setObjText("Esquiva los obstaculos y junta 50 puntos para ganar")
	Eagle.connect("gameStart",self, "startgame")
	Eagle.connect("gameStop",self,"stopgame")
	ObstSpawner.connect("obstacle_created", self, "_on_obstacle_created")

func startgame():
	Score.visible = true 
	ObstSpawner.start()

func stopgame():
	clearObstacles()
	ObstSpawner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("jump_obstacle","set_physics_process",false)
	$Score.visible = false
	if not won:
		$endGame/Panel/Button.text = "Salir"
		$endGame/Panel/Button2.text = "Reintentar"
		$endGame/Panel/Results.text = "¡Qué lástima!"
		$endGame/Panel/Results.rect_position = Vector2(238,270)
		$endGame/Panel/Puntos.text = "%s / 50" % str(Score.score)
		$endGame/Panel/Puntos.rect_position = Vector2(611.5,345)
	elif won:
		$endGame/Panel/Button.text = "Jugar de nuevo"
		$endGame/Panel/Button2.text = "Continuar"
		$endGame/Panel/Results.text = "¡Felicidades, has superado los obstaculos!"
		$endGame/Panel/Results.rect_position = Vector2(238,270)
		$endGame/Panel/Puntos.text = "%s / 50" % str(Score.score)
		$endGame/Panel/Puntos.rect_position = Vector2(611.5,345)
	Eagle.visible = false
	$AnimationPlayer.play("result_scrn")

func updateScore():
	Score.updateScore()
	if Score.score == 50:
		won = true
		stopgame()
func clearObstacles() -> void:
	for x in get_tree().get_nodes_in_group("jump_obstacle"):
		x.queue_free()

func _on_obstacle_created(obs):
	obs.connect("score",self,"updateScore")

func exitGame() -> void:
	$AnimationPlayer.play("result_scrn_out")
	yield(get_tree().create_timer(0.6),"timeout")
	queue_free()

func tryAgain() -> void:
	ground.get_node("AnimationPlayer").play("scroll")
	Eagle.reset()
	Eagle.position = Vector2(230,546)
	$AnimationPlayer.play("result_scrn_out")
	Eagle.visible = true

func _on_Button_pressed():
	if $endGame/Panel/Button.text == "Salir":
		exitGame()
	if $endGame/Panel/Button.text == "Jugar de nuevo":
		tryAgain()

func _on_Button2_pressed():
	if $endGame/Panel/Button2.text == "Reintentar":
		tryAgain()

	if $endGame/Panel/Button2.text == "Continuar":
		exitGame()
