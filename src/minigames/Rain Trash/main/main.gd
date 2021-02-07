extends CanvasLayer

## Engine things
onready var spawnPoints : Node2D = get_node("World/Spawn_Points")
onready var spawnTimer: Timer = get_node("World/Spawn_Points/Timer")
onready var boardDuration: Timer = get_node("UI/BoardDuration")
onready var fallTrash = preload("res://minigames/Rain Trash/Trash/Trash.tscn")
var idGame = "RT"
var _paused = false
signal go_on
##SCORETHINGS
export var phaseDuration: int = 30
export var winRequire: int = 0
export var defaultRemainTimer = 1.5
export var lifes: int = 10
var totalCatched: int = 0
var score: int = 0
var lastScore: int = 0
export var currBoard : int = 0
var maxBoards: int = 6
var lastTime: int = 0

## UI Things
onready var effects: AnimationPlayer = get_node("UI/Effects/AnimationPlayer")
onready var player = get_node("Player")

## UIThings: Labels
onready var score_label: Label = get_node("UI/Score/Score")
onready var remaining_lifes: Label = get_node("UI/Vidas/lifes")

## UI Things: Botones
onready var start_button : TextureButton = get_node("UI/Start")
onready var exit_button : TextureButton = get_node("UI/Salir")
onready var pause_button : TextureButton = get_node("UI/Pause")

## UI Things: Objetivo actual
onready var objective = preload("res://minigames/UI_Reusable/_Objective.tscn")
onready var spriteObjective: Sprite = get_node("UI/CurrentObjective/SpriteObj")
onready var currentObjective: Panel = get_node("UI/CurrentObjective")

## UI Things: Pantalla de resultados
onready var label_row1: Label = get_node("UI/endGame/Panel/Results")
onready var label_row2: Label = get_node("UI/endGame/Panel/maxPuntos")
onready var leftButton: Button = get_node("UI/endGame/Panel/Button")
onready var rightButton: Button = get_node("UI/endGame/Panel/Button2")

## UI Things : Load_Game
onready var load_scrn: Panel = get_node("UI/load_game")
onready var scrn_disclaimer: Label = get_node("UI/load_game/Desc")
## Tutorial
onready var tutUI = preload("res://ui/Interfaces/tutorialScreen/tutorialUI.tscn")

func _ready():
	GLOBALS.initVolumeAudio()
	if ProfileManager.tutorialsEnabled:
		var _tutUI = tutUI.instance()
		_tutUI.tutoName = "M1"
		add_child(_tutUI)
		yield(_tutUI,"tree_exited")
	currBoard = SCRSYSTEM.clearedPhases
	spawnTimer.wait_time = defaultRemainTimer
	player.connect("catched", self, "updateScore")
	score_label.text = str(score)
	remaining_lifes.text = str(lifes)
	randomize()
	boardDuration.set_wait_time(phaseDuration)


func _process(delta):
	if not _paused:
		boardDuration.paused = false
		spawnTimer.paused = false
		$UI/RemainingTime.text = str(int(boardDuration.get_time_left()))
	else:
		boardDuration.paused = true
		spawnTimer.paused = true

func _physics_process(delta):
	pauseMenu()

func updateScore(isCorrect: bool, isGolden: bool) -> void:
	if isCorrect:	## Si la basura recogida corresponde a la del objetivo actual
		effects.play("scoreUp")	## Se ejecuta un efecto visual indicando que fue correcto
		if isGolden:
			score+=300
		else:
			score += 150			## Se aumenta en 100 puntos el score 
		totalCatched += 1		## Se aumenta la cantidad de basura recogida	
		makeHarder()
	else:
		effects.play("ScoreDown")
		lifes -= 1
		remaining_lifes.text = str(lifes)
		if lifes == 0: _lose()
		if score - 100 < 0: score = 0
		else: score -= 100
	score_label.text = str(score)

func makeHarder() -> void:
	if int(boardDuration.get_time_left()) % 20 == 0:
		spawnTimer.wait_time = spawnTimer.wait_time - 0.35

func destroy_remainTrash() -> void:
	var remain_trash = get_tree().get_nodes_in_group("falling_trash")
	for t in remain_trash:
		t.queue_free()

func _win() -> void:
	destroy_remainTrash()
	spawnTimer.stop()
	spawnTimer.wait_time = defaultRemainTimer
	player.visible = false
	pause_button.visible = false
	player.set_physics_process(false)
	currentObjective.visible = false
	currBoard += 1         ## Se suma uno al indice del tipo de residuo
	var data: Array = []
	lastScore = score
	data.append(currBoard)
	data.append(score)
	SCRSYSTEM._updateMiniGame(idGame, data)
	label_row1.text = "Has superado:"
	label_row2.visible = true
	var text = " de 6 fases"
	label_row2.text = str(currBoard) + text
	effects.play("ResultScreen_Enter")
	if currBoard >= maxBoards:
		label_row1.text = "¡Felicidades! \nSuperaste todas las fases del juego."
		label_row2.visible = false
		leftButton.text = "Reiniciar"
		rightButton.text = "Completar"
		SCRSYSTEM._clearGame(idGame)

func _lose() -> void:
	lifes = 5
	boardDuration.stop()
	destroy_remainTrash()
	spawnTimer.stop()
	pause_button.visible = false
	player.visible = false
	player.set_physics_process(false)
	label_row1.text = "¡Mala suerte! No lograste recoger la basura pedida"
	label_row2.visible = false
	rightButton.text = "Reintentar"
	effects.play("ResultScreen_Enter")
##
func pauseMenu() -> void:
	if Input.is_action_just_pressed("pause"):
		var _objective = canvasObjective()
		get_tree().paused = true
		
func canvasObjective():
	var _objective = objective.instance()
	_objective.layer = 2
	_objective.obj = "Recolecta solo los residuos de tipo " + ItemDb.get_NameTrash(currBoard + 1)
	_objective.showTrashTextures(currBoard + 1)
	add_child(_objective)
	return _objective
##
func spawnTrash() -> void:
	var pos = randi() % 6
	var type = randi() % 6
	
	if type != currBoard:
		lastTime += 1
	if lastTime == 8:
		lastTime =0
		type = currBoard

	var spawns = spawnPoints.get_children()
	var currTrash = fallTrash.instance()
	currTrash._currBoard = currBoard
	currTrash.Trash_Type = type
	currTrash.position = spawns[pos].position
	add_child(currTrash)

func _on_Area2D_body_entered(body):
	if body.Trash_Type == player.type:
		$World/Destruction_Area/AudioStreamPlayer2D.play()
		updateScore(false, false)
	body.queue_free()


func _on_Timer_timeout():
	spawnTrash()


func _on_Start_pressed():
	$TextureRect.visible = false
	if currBoard != 0:
		scrn_disclaimer.text = "Parece que jugaste anteriormente y avanzaste %s fases antes de perder o salir voluntariamente del minijuego." % currBoard
		load_scrn.visible = true
		yield(self,"go_on")
	start_button.visible = false
	exit_button.visible = false
	player.type = currBoard
	player.changeSprite(currBoard)
	##
	var _objective = canvasObjective()
	yield(_objective,"tree_exited")
	##
	pause_button.visible = true
	$UI/Score.visible = true
	$UI/Vidas.visible = true
	$UI/RemainingTime.visible = true
	player.visible = true
	spriteObjective.texture = load(ItemDb.get_LabelTrash(currBoard + 1))
	currentObjective.visible = true
	player.set_physics_process(true)
	spawnTimer.start()
	boardDuration.start()

func _on_Button2_pressed():
	if currBoard < maxBoards:
		score = 0			   ## Se resetea el puntaje
		score_label.text = str(score) ##Se resetea el puntaje en la pantalla
		remaining_lifes.text = str(lifes)
		player.type = currBoard	## Se le indica al jugador el tipo de residuo que deberá atrapar
		effects.play("ResultScreen_Out")		## Se quita la pantalla de resultados
		##
		var _objective = canvasObjective()
		yield(_objective,"tree_exited")
		##
		boardDuration.start()
		pause_button.visible = true
		player.changeSprite(currBoard)
		player.visible = true	## Se hace visible el jugador
		spriteObjective.texture = load(ItemDb.get_LabelTrash(currBoard+1))  ##Se carga la textura del residuo objetivo
		currentObjective.visible = true	  	## Se hace visible la textura del residuo objetivo
		player.set_physics_process(true)	  	## Habilitamos las físicas del jugador
		spawnTimer.start()					  	## Se inicia el timer del spawn de residuos
		start_button.visible = false	##		

	else: ## Completar minijuego
		queue_free()

func _on_Pause_pressed():
	pause_button.visible = false
	get_tree().paused = true
	_paused = not _paused
	var _objective = canvasObjective()
	yield(_objective,"tree_exited")
	pause_button.visible = true
	get_tree().paused = false
	_paused = not _paused

func _on_Salir_pressed():
	_closeMinigame()

func _closeMinigame() -> void:
	$UI/Effects/AnimationPlayer.play("fadeOut")
	yield($UI/Effects/AnimationPlayer,"animation_finished")
	queue_free()

func _on_Button_pressed():
	$UI/Effects/AnimationPlayer.play("ResultScreen_Out")
	yield($UI/Effects/AnimationPlayer,"animation_finished")
	_closeMinigame()


func _on_Restart_pressed():
	load_scrn.visible = false
	currBoard = 0
	lifes = 5
	score = 0
	emit_signal("go_on")

func _on_Load_pressed():
	load_scrn.visible = false
	emit_signal("go_on")


func _on_BoardDuration_timeout():
	boardDuration.stop()
	_win()


func _on_Config_pressed():
	pass # Replace with function body.
