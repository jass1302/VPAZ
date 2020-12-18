extends CanvasLayer
onready var board = preload("res://minigames/JigSaw Game/board/Board.tscn")
onready var timerUI = get_node("Timer/VBoxContainer/Tiempo")
var paused: bool = true
var time = 0
var time_mult = 1.0

func _ready():
	pass

func _process(delta):
	if not paused:
		setTime(delta)

func setTime(delta) -> void:
	time += time_mult * delta
	timerUI.text = str(int(time))
	
func _on_boardCompleted() -> void:
	print("Completado")
	paused = true
	get_tree().get_nodes_in_group("JigsawBoard")[0].queue_free()
	$Timer/VBoxContainer.visible = false
	$endGame.visible = true
	$endGame/Panel/maxPuntos.text = "%s segundos." % str(int(time))
	$AnimationPlayer.play("result_scrn")

func instaceBoard(boardName: String) -> void:
	$AnimationPlayer.play("out_selection")
	yield($AnimationPlayer,"animation_finished")
	var _board = board.instance()
	_board.puzzleName = boardName
	_board.connect("boardCompleted",self,"_on_boardCompleted")
	add_child(_board)
	$SelectBoards.visible = false
	paused = false
	$Timer/VBoxContainer.visible = true


func _on_Start_pressed():
	$Start.visible=false
	$SelectBoards.visible = true
	$AnimationPlayer.play("enter_selection")


func _on_select_board1_pressed():
	instaceBoard("board1")


func _on_select_board2_pressed():
	instaceBoard("board2")


func _on_select_board3_pressed():
	instaceBoard("board3")


func _on_Button2_pressed():
	queue_free()


func _on_Button_pressed():
	time = 0
	$Start.visible = true
	$SelectBoards.visible = false
	$AnimationPlayer.play("result_scrn_out")
	yield($AnimationPlayer,"animation_finished")
	$endGame.visible = false
