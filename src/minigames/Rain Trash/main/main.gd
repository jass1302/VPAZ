extends CanvasLayer

## Engine things
onready var spawnPoints : Node2D = get_node("World/Spawn_Points")
onready var spawnTimer: Timer = get_node("World/Spawn_Points/Timer")
onready var fallTrash = preload("res://minigames/Rain Trash/Trash/Trash.tscn")

##SCORETHINGS
export var winRequire: int = 0
export var defaultRemainTimer = 1.5
export var maxTrash: int = 1
export var lifes: int = 10
var totalCatched: int = 0
var score: int = 0
export var currBoard : int = 5
var maxBoards: int = 6
var lastTime: int = 0

## UI Things
onready var effects: AnimationPlayer = get_node("UI/Effects/AnimationPlayer")
onready var player = get_node("Player")

## UIThings: Labels
onready var score_label: Label = get_node("UI/Score/Score")

## UI Things: Botones
onready var start_button : Button = get_node("UI/Start")
onready var exit_button : Button = get_node("UI/Salir")
onready var pause_button : Button = get_node("UI/Pause")

## UI Things: Objetivo actual
onready var objective = preload("res://minigames/UI_Reusable/_Objective.tscn")
onready var spriteObjective: Sprite = get_node("UI/CurrentObjective/SpriteObj")
onready var currentObjective: Panel = get_node("UI/CurrentObjective")

## UI Things: Pantalla de resultados
onready var label_row1: Label = get_node("UI/endGame/Panel/Results")
onready var label_row2: Label = get_node("UI/endGame/Panel/maxPuntos")
onready var leftButton: Button = get_node("UI/endGame/Panel/Button")
onready var rightButton: Button = get_node("UI/endGame/Panel/Button2")

func _ready():
	spawnTimer.wait_time = defaultRemainTimer
	player.connect("catched", self, "updateScore")
	score_label.text = str(score)
	randomize()

func reset() -> void:
	pass

func _physics_process(delta):
	pauseMenu()

func updateScore(isCorrect: bool) -> void:
	if isCorrect:	## Si la basura recogida corresponde a la del objetivo actual
		effects.play("scoreUp")	## Se ejecuta un efecto visual indicando que fue correcto
		score += 100			## Se aumenta en 100 puntos el score 
		totalCatched += 1		## Se aumenta la cantidad de basura recogida	
		_win()
		makeHarder()
	else:
		effects.play("ScoreDown")
		lifes -= 1
		if lifes == 0: _lose()
		if score - 100 < 0: score = 0
		else: score -= 100
	score_label.text = str(score)

func makeHarder() -> void:
	if totalCatched % 5 == 0:
		spawnTimer.wait_time = spawnTimer.wait_time - 0.35

func destroy_remainTrash() -> void:
	var remain_trash = get_tree().get_nodes_in_group("falling_trash")
	for t in remain_trash:
		t.queue_free()

func _win() -> void:
	if score == winRequire:
		destroy_remainTrash()
		spawnTimer.stop()
		spawnTimer.wait_time = defaultRemainTimer
		player.visible = false
		pause_button.visible = false
		player.set_physics_process(false)
		currentObjective.visible = false
		currBoard += 1         ## Se suma uno al indice del tipo de residuo
		var text = " de 6 fases"
		label_row2.text = str(currBoard) + text
		effects.play("ResultScreen_Enter")
		if currBoard >= maxBoards:
			label_row1.text = "¡Felicidades! \nSuperaste todas las fases del juego."
			label_row2.visible = false
			leftButton.text = "Reiniciar"
			rightButton.text = "Completar"

func _lose() -> void:
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
	currTrash.Trash_Type = type
	currTrash.position = spawns[pos].position
	add_child(currTrash)

func _on_Area2D_body_entered(body):
	if body.Trash_Type == player.type:
		updateScore(false)
	body.queue_free()


func _on_Timer_timeout():
	spawnTrash()


func _on_Start_pressed():
	start_button.visible = false
	exit_button.visible = false
	pause_button.visible = true
	player.type = currBoard
	##
	var _objective = canvasObjective()
	yield(_objective,"tree_exited")
	##
	player.visible = true
	spriteObjective.texture = load(ItemDb.get_LabelTrash(currBoard + 1))
	currentObjective.visible = true
	player.set_physics_process(true)
	spawnTimer.start()


func _on_Button2_pressed():
	if currBoard < maxBoards:
		score = 0			   ## Se resetea el puntaje
		score_label.text = str(score) ##Se resetea el puntaje en la pantalla
		player.type = currBoard	## Se le indica al jugador el tipo de residuo que deberá atrapar
		effects.play("ResultScreen_Out")		## Se quita la pantalla de resultados
		##
		var _objective = canvasObjective()
		yield(_objective,"tree_exited")
		##
		pause_button.visible = true
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
	var _objective = canvasObjective()
	get_tree().paused = true
	pause_button.visible = true


func _on_Salir_pressed():
	queue_free()


func _on_Button_pressed():  ## Reiniciar o salir
	queue_free()
