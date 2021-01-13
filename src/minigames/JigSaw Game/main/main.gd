extends CanvasLayer
var gameID: String = "Jigsaw"
onready var board = preload("res://minigames/JigSaw Game/board/Board.tscn")
onready var timerUI = get_node("Timer/VBoxContainer/Tiempo")
onready var objective = preload("res://minigames/UI_Reusable/_Objective.tscn")
var paused: bool = true
var time = 0
var time_mult = 1.0

## Tutorial
onready var tutUI = preload("res://ui/Interfaces/tutorialScreen/tutorialUI.tscn")

func _ready():
	if ProfileManager.tutorialsEnabled:
		var _tutUI = tutUI.instance()
		_tutUI.tutoName = "M3"
		add_child(_tutUI)
		yield(_tutUI,"tree_exited")

func _process(delta):
	if not paused:
		setTime(delta)

func setTime(delta) -> void:
	time += time_mult * delta
	timerUI.text = str(int(time))

func canvasObjective():
	var _objective = objective.instance()
	_objective.layer = 2
	_objective.obj = "Completa el rompecabezas"
	add_child(_objective)
	return _objective

func _on_boardCompleted() -> void:
	$Pause.visible = false
	paused = true
	get_tree().get_nodes_in_group("JigsawBoard")[0].queue_free()
	$Timer/VBoxContainer.visible = false
	$endGame.visible = true
	$endGame/Panel/maxPuntos.text = "%s segundos." % str(int(time))
	$AnimationPlayer.play("result_scrn")
	var data: Array = []
	data.append(int(time))
	SCRSYSTEM._updateMiniGame(gameID,data)
	SCRSYSTEM._clearGame(gameID)

func instaceBoard(boardName: String) -> void:
	$Salir.visible = false
	$AnimationPlayer.play("out_selection")
	yield($AnimationPlayer,"animation_finished")
	var _board = board.instance()
	_board.puzzleName = boardName
	_board.connect("boardCompleted",self,"_on_boardCompleted")
	add_child(_board)
	$SelectBoards.visible = false
	var _objective = canvasObjective()
	yield(_objective,"tree_exited")
	$Pause.visible = true
	paused = false
	$Timer/VBoxContainer.visible = true


func _on_Start_pressed():
	$Start.visible = false
	$background.visible = false
	$SelectBoards.visible = true
	$AnimationPlayer.play("enter_selection")
	


func _on_select_board1_pressed():
	instaceBoard("board1")


func _on_select_board2_pressed():
	instaceBoard("board2")


func _on_select_board3_pressed():
	instaceBoard("board3")


func _on_Button2_pressed():
	$AnimationPlayer.play("result_scrn_out")
	yield(get_tree().create_timer(0.6),"timeout")
	$AnimationPlayer.play("fadeOut")
	yield($AnimationPlayer,"animation_finished")
	queue_free()

func _on_Button_pressed():
	time = 0
	$background.visible = true
	$Start.visible = true
	$SelectBoards.visible = false
	$AnimationPlayer.play("result_scrn_out")
	yield($AnimationPlayer,"animation_finished")
	$endGame.visible = false


func _on_Pause_pressed():
	paused = true
	var _objective = canvasObjective()
	yield(_objective,"tree_exited")
	paused = false
	


func _on_Salir_pressed():
	$AnimationPlayer.play("fadeOut")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
