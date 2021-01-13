extends CanvasLayer

onready var findIt_Interface = preload("res://minigames/FindOnTexture/image/findit_interface/SelectSubject.tscn")
onready var findImageScn = preload("res://minigames/FindOnTexture/image/Image.tscn")
onready var objective = preload("res://minigames/UI_Reusable/_Objective.tscn")

var indx: int = 0
var remainingAttemps: int
var clearedImages = [
	false,
	false,
	false,
	false,
	false,
	false,
	false
]
var closeButtonState: int = 0
var isPanelOnScrn: bool = false

## Tutorial
onready var tutUI = preload("res://ui/Interfaces/tutorialScreen/tutorialUI.tscn")

func _ready():
	if ProfileManager.tutorialsEnabled:
		var _tutUI = tutUI.instance()
		_tutUI.tutoName = "M8"
		add_child(_tutUI)
		yield(_tutUI,"tree_exited")
	$AnimationPlayer.play("outTiles")
	yield(get_tree().create_timer(1.5),"timeout")
	$Start.visible = true

func canvasObjective():
	var _objective = objective.instance()
	_objective.layer = 2
	_objective.obj = "Toca la imagen para hacer acercamientos."
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
			scn.trueX = 1
			scn.trueY = 2
		2:
			scn.cols = 8
			scn.rows = 8
			scn.trueX = 4
			scn.trueY = 1
		3:
			scn.cols = 8
			scn.rows = 8
			scn.trueX = 3
			scn.trueY = 6
		4:
			scn.cols = 8
			scn.rows = 8
			scn.trueX = 7
			scn.trueY = 3
		5:
			scn.cols = 8
			scn.rows = 8
			scn.trueX = 5
			scn.trueY = 4
		6:
			scn.cols = 8
			scn.rows = 8
			scn.trueX = 2
			scn.trueY = 1
		7:
			scn.cols = 8
			scn.rows = 8
			scn.trueX = 4
			scn.trueY = 3

	scn.generateButtonGrid()
	add_child(scn)

func _on_Start_pressed():
	$Start.visible = false
	$SelectBoards.visible = true
	$AnimationPlayer.play("inTiles")
	yield($AnimationPlayer,"animation_finished")
	$Instruct.visible = true
	$Salir.visible = true
	
func updateAttemptsLabel() -> void:
	remainingAttemps -= 1
	$LifesLabel.text = "Intentos restantes: %s" % str(remainingAttemps)
	$endGame/Panel/maxPuntos.text = str(remainingAttemps)

func instanceFindImage(ind: int) -> void:
	$Salir.visible = false
	$AnimationPlayer.play("outTiles")
	$Instruct.visible = false
	yield($AnimationPlayer,"animation_finished")
	$SelectBoards.visible = false
	remainingAttemps = 4 
	updateAttemptsLabel()
	var _findImageScn = findImageScn.instance()
	_findImageScn.setTexture(ind)
	$ImgHolder.add_child(_findImageScn)
	$Button.visible = true
	indx = ind
	$LifesLabel.visible = true
	setObjectiveTexture(ind)
	$AnimationPlayer.play("enter_objective")

func wasFound(isCorrect: bool) -> void:
	var imageScn = get_tree().get_nodes_in_group("waldos_look")[0]
	var waldoGrid = get_tree().get_nodes_in_group("waldo_grid")[0]
	if isCorrect:
		clearedImages[indx - 1] = true
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
	if closeButtonState == 2:
		get_tree().get_nodes_in_group("waldos_look")[0].queue_free()
		get_tree().get_nodes_in_group("waldo_grid")[0].queue_free()
	if closeButtonState == 1:
		get_tree().get_nodes_in_group("waldos_look")[0].queue_free()
	$AnimationPlayer.play("result_scrn_out")
	yield(get_tree().create_timer(0.6),"timeout")
	$SelectBoards.visible = true
	$AnimationPlayer.play("inTiles")
	closeButtonState = 0
	$Salir.visible = true

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

func setObjectiveTexture(i: int) ->void:
	var newText: Texture
	match i:
		1: newText = load("res://minigames/FindOnTexture/assets/cards/Aquila real.png")
		2: newText = load("res://minigames/FindOnTexture/assets/cards/Berrendo.png")
		3: newText = load("res://minigames/FindOnTexture/assets/cards/Gavilan.png")
		4: newText = load("res://minigames/FindOnTexture/assets/cards/Musarana .png")
		5: newText = load("res://minigames/FindOnTexture/assets/cards/Perrito1.png")
		6: newText = load("res://minigames/FindOnTexture/assets/cards/Pino Azul.png")
		7: newText = load("res://minigames/FindOnTexture/assets/cards/Vibora de cascabel.png")
	$Objetive/VBoxContainer/TextureRect.texture = newText

func _on_select_board4_pressed():
	instanceFindImage(4)


func _on_select_board5_pressed():
	instanceFindImage(5)


func _on_select_board6_pressed():
	instanceFindImage(6)


func _on_select_board7_pressed():
	instanceFindImage(7)


func _on_Salir_pressed():
	if closeButtonState == 0:
		$AnimationPlayer.play("outTiles")
		yield($AnimationPlayer,"animation_finished")
		queue_free()
	if closeButtonState == 1:
		tryAgain()


func _on_EnterObjective_pressed():
	$AnimationPlayer.play("out_objective")
	yield($AnimationPlayer,"animation_finished")
	var _objective = canvasObjective()
	yield(_objective,"tree_exited")
	closeButtonState = 1
	$Salir.visible = true
