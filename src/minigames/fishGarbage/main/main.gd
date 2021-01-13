extends CanvasLayer

onready var rod = get_node("fishing_rod")
onready var garbage = preload("res://minigames/fishGarbage/garbage/Garbage.tscn")
onready var spawnPoints = get_node("spawnPoints")
export var time = 60
var _time
var winGoal: int = 20
var score: int = 0
var time_mult = 1.0
var paused = true

func _ready():
	_time = time
	spawnGarbage()
	$UI/Objective/VBoxContainer/tiempo.text = "Tiempo restante: %s" % str(int(time))
	$FishingNet.connect("collected", self, "upScore")
func _process(delta):
	if not paused:
		setTime(delta)

func setTime(delta) -> void:
	time -= time_mult * delta
	$UI/Objective/VBoxContainer/tiempo.text = "Tiempo restante: %s" % str(int(time))
	if time < 1:
		paused = true
		rod.started = false
		$endGame/Panel/Results.text = "¡Qué lástima!"
		$endGame/Panel/Puntos.text = "Te faltaron pescar %s para ganar" %str(winGoal - score)
		$endGame/Panel/Button.text = "Salir"
		$endGame/Panel/Button2.text = "Reintentar"
		$AnimationPlayer.play_backwards("ObjectiveScoreInFish")
		yield($AnimationPlayer,"animation_finished")
		$AnimationPlayer.play("result_scrn")

func upScore() -> void:
	score +=1
	$UI/Score/VBoxContainer/Count.text = "%s / 20" %score
	if score == winGoal:
		paused = true
		rod.started = false
		$endGame/Panel/Results.text = "¡Felicidades, has ganado!"
		$endGame/Panel/Puntos.visible = false
		$endGame/Panel/Button.text = "Reintentar"
		$endGame/Panel/Button2.text = "Continuar"
		$AnimationPlayer.play_backwards("ObjectiveScoreInFish")
		yield($AnimationPlayer,"animation_finished")
		$AnimationPlayer.play("result_scrn")

func spawnGarbage() -> void:
	for spawn in spawnPoints.get_children():
		var _garbage = garbage.instance()
		_garbage.returningPoint = spawn
		_garbage.originalPoint = spawn
		spawn.add_child(_garbage)

func quit() -> void:
	$AnimationPlayer.play("result_scrn_out")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("fadeOut")
	yield($AnimationPlayer,"animation_finished")
	queue_free()

func retry() -> void:
	for g in get_tree().get_nodes_in_group("garbageWater"):
		g.queue_free()
	time = _time
	score = 0
	$UI/Score/VBoxContainer/Count.text = "%s / 20" %score
	$AnimationPlayer.play("result_scrn_out")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("ObjectiveScoreInFish")
	$FishingNet.depositInd = 0
	spawnGarbage()
	paused = false
	rod.started = true
	rod._body = null
	
func _on_Start_pressed():
	$background2.visible = false
	paused = false
	$UI/Start.visible = false
	rod.started = true
	rod.visible = true
	$AnimationPlayer.play("ObjectiveScoreInFish")


func _on_Button_pressed():
	if $endGame/Panel/Button.text == "Salir":
		quit()
	if $endGame/Panel/Button.text == "Reintentar":
		retry()


func _on_Button2_pressed():
	if $endGame/Panel/Button2.text == "Continuar":
		quit()
	if $endGame/Panel/Button2.text == "Reintentar":
		retry()
