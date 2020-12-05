extends Node

var questionPool: Array = [0,0,0,0,0,0,0,0,0,0,0]

signal started
signal nextPool
signal finished

var correctAnswers: int = 0
var wasCorrect : bool
var maxQuestions: int =  5

onready var board = preload("res://minigames/cup_questions/table/Board.tscn")
var poolInd: int

func _ready():
	connect("started", self, "loadFirstTable")
	connect("nextPool", self, "nextPool")
	connect("finished", self, "endGame")
	randomize()
	$AnimationPlayer.play("scoreDefault")

func loadFirstTable():
	poolInd += 1
	var starPool = board.instance()
	starPool._questions = poolMaker()
	add_child(starPool)
	yield(starPool,"tree_exited")
	emit_signal("nextPool")
	
func nextPool() -> void:
	poolInd += 1
	updateScore()
	yield(get_tree().create_timer(1), "timeout")
	
	var _nextPool = board.instance()
	_nextPool._questions = poolMaker()
	
	add_child(_nextPool)
	yield(_nextPool,"tree_exited")
	
	if poolInd == maxQuestions:
		emit_signal("finished")
	else:
		emit_signal("nextPool")

func endGame() -> void:
	updateScore()
	$Label.visible = false
	$endGame/Panel/Puntos.text = str(correctAnswers)
	$AnimationPlayer.play("result_scr")
	if correctAnswers >= 6:
		$endGame/Panel/Button2.visible = true


func reset() -> void:
	correctAnswers = 0
	$Start.visible = true
	$Label.text = "0"
	$Label.visible = true

func updateScore() -> void:
	print(wasCorrect)
	if wasCorrect:
		$AnimationPlayer.play("scoreUp")
		yield(get_tree().create_timer(0.75), "timeout")
		$Label.text = str(correctAnswers)
		yield(get_tree().create_timer(0.75), "timeout")
	if not wasCorrect:
		$AnimationPlayer.play("scoreSame")
		yield(get_tree().create_timer(0.4), "timeout")
		$Label.text = str(correctAnswers)
		yield(get_tree().create_timer(0.75), "timeout")
	$AnimationPlayer.play("scoreDefault")	
func poolMaker() -> Array:
	var tempPool = []
	for x in questionPool:
		tempPool.append(x)
	var outPool = []

	for i in range(3):
		var rand = randi()%10 +1
		while tempPool[rand] == rand:
			rand = randi()%10 + 1
		tempPool[rand] = rand
		outPool.append(rand)
	return outPool

func _on_Start_pressed():
	$Start.visible = false
	emit_signal("started")
	


func _on_Button_pressed():
	reset()
	$AnimationPlayer.play("result_scrn_out")


func _on_Button2_pressed():
	queue_free()
