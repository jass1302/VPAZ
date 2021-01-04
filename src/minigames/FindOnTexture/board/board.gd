extends CanvasLayer

onready var findIt_Interface = preload("res://minigames/FindOnTexture/image/findit_interface/SelectSubject.tscn")
onready var findImageScn = preload("res://minigames/FindOnTexture/image/Image.tscn")
onready var objective = preload("res://minigames/UI_Reusable/_Objective.tscn")

var indx: int = 0
var remainingAttemps: int
var clearedImages = [
	false,
	false,
	false
]

func canvasObjective():
	var _objective = objective.instance()
	_objective.layer = 2
	_objective.obj = "Encuentra al %personaje%"
	add_child(_objective)
	return _objective

func _on_Button_pressed():
	$Button.visible = false
	var imageScn = get_tree().get_nodes_in_group("waldos_look")[0]
	imageScn.visible = false
	imageScn.visible = false
	if get_tree().get_nodes_in_group("waldo_grid").empty():
		var _findIt = findIt_Interface.instance()
		_findIt.connect("foundIt", self, "wasFound")
		_findIt.setImage(imageScn.spr)
		_findIt.scale = imageScn.scale
		_findIt.position = imageScn.position
		setProperties(_findIt)
	else:
		get_tree().get_nodes_in_group("waldo_grid")[0].visible = true

func setProperties(scn) -> void:
	match indx:
		1:
			scn.cols = 8
			scn.rows = 8
			scn.trueX = 2
			scn.trueY = 2
		2:
			scn.cols = 8
			scn.rows = 8
			scn.trueX = 7
			scn.trueY = 7
		3:
			scn.cols = 8
			scn.rows = 8
			scn.trueX = 3
			scn.trueY = 3
	scn.generateButtonGrid()
	add_child(scn)

func _on_Start_pressed():
	$Start.visible = false
	$SelectBoards.visible = true
	$AnimationPlayer.play("enter_selection")
	
func updateAttemptsLabel() -> void:
	remainingAttemps -= 1
	$LifesLabel.text = "Intentos restantes: %s" % str(remainingAttemps)
	$endGame/Panel/maxPuntos.text = str(remainingAttemps)

func instanceFindImage(ind: int) -> void:
	$AnimationPlayer.play("out_selection")
	yield(get_tree().create_timer(1.2),"timeout")
	remainingAttemps = 4 
	updateAttemptsLabel()
	var _findImageScn = findImageScn.instance()
	_findImageScn.setTexture(ind)
	$ImgHolder.add_child(_findImageScn)
	$SelectBoards.visible = false
	$Button.visible = true
	indx = ind
	$LifesLabel.visible = true
	var _objective = canvasObjective()
	yield(_objective,"tree_exited")

func wasFound(isCorrect: bool) -> void:
	var imageScn = get_tree().get_nodes_in_group("waldos_look")[0]
	var waldoGrid = get_tree().get_nodes_in_group("waldo_grid")[0]
	if isCorrect:
		clearedImages[indx - 1] = true
		print(clearedImages)
		$endGame/Panel/Button.text = "Selección de imagenes"
		$endGame/Panel/Button2.text = "Continuar"
		$endGame/Panel/Results.text = "¡Correcto, lo has encontrado!"
		yield(get_tree().create_timer(1),"timeout")
		imageScn.visible = true
		waldoGrid.visible = false
		$LifesLabel.visible = false
		$AnimationPlayer.play("result_scrn")
		yield(get_tree().create_timer(0.6),"timeout")
		$AnimationPlayer.play("remainingattemps_green")
		yield(get_tree().create_timer(0.15),"timeout")
		$endGame/Panel/Button.visible = true
		$endGame/Panel/Button2.visible = true
		
	else:
		$endGame/Panel/Button.visible = false
		$endGame/Panel/Button2.visible = false
		$endGame/Panel/Results.text = "Respuesta incorrecta. Intenta de nuevo."
		yield(get_tree().create_timer(1),"timeout")
		waldoGrid.visible = false
		$LifesLabel.visible = false
		$AnimationPlayer.play("result_scrn")
		yield(get_tree().create_timer(0.6),"timeout")
		$AnimationPlayer.play("remainingattemps_red")
		yield(get_tree().create_timer(0.15),"timeout")
		updateAttemptsLabel()
		if remainingAttemps > 0:
			yield(get_tree().create_timer(1),"timeout")
			$LifesLabel.visible = false
			$AnimationPlayer.play("result_scrn_out")
			yield(get_tree().create_timer(0.6),"timeout")
			$Button.visible = true
			imageScn.visible = true
		else:
			$endGame/Panel/Button.text = "Salir"
			$endGame/Panel/Button.visible = true
			$endGame/Panel/Button2.text = "Reintentar"
			$endGame/Panel/Button2.visible = true

func tryAgain() -> void:
	get_tree().get_nodes_in_group("waldos_look")[0].queue_free()
	get_tree().get_nodes_in_group("waldo_grid")[0].queue_free()
	$AnimationPlayer.play("result_scrn_out")
	yield(get_tree().create_timer(0.6),"timeout")
	$SelectBoards.visible = true
	$AnimationPlayer.play("enter_selection")

func _on_select_board1_pressed():
	instanceFindImage(1)


func _on_select_board2_pressed():
	instanceFindImage(2)


func _on_select_board3_pressed():
	instanceFindImage(3)


func _on_Button2_pressed():
	if $endGame/Panel/Button2.text == "Continuar":
		$AnimationPlayer.play("result_scrn_out")
		yield(get_tree().create_timer(0.6),"timeout")
		queue_free()
	if $endGame/Panel/Button2.text == "Reintentar":
		tryAgain()

func _on_EButton_pressed():
	if $endGame/Panel/Button.text == "Selección de imagenes":
		tryAgain()
	if $endGame/Panel/Button.text == "Salir":
		$AnimationPlayer.play("result_scrn_out")
		yield(get_tree().create_timer(0.6),"timeout")
		queue_free()
