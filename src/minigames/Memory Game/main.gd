extends CanvasLayer

export var cant_cards : int = 2

onready var cardPre = preload("res://minigames/Memory Game/Card/Card.tscn")
onready var objective = preload("res://minigames/UI_Reusable/_Objective.tscn")
onready var timer: Timer = $Timer

var paused: bool = true
var time = 0
var time_mult = 1.0

var up_card = null ## Carta boca arriba xdxd
var _cards = []   ##Pa' guardar mis caritas uwu

var current_count = 0

## Tutorial
onready var tutUI = preload("res://ui/Interfaces/tutorialScreen/tutorialUI.tscn")

func _ready():
	if ProfileManager.tutorialsEnabled:
		var _tutUI = tutUI.instance()
		_tutUI.tutoName = "M5"
		add_child(_tutUI)
		yield(_tutUI,"tree_exited")

	randomize()
	timer.connect("timeout", self, "finished_time")
	
func _process(delta):
	if not paused:
		setTime(delta)

func setTime(delta) -> void:
	time += time_mult * delta
	$TimePassed.text = "Tiempo transcurrido\n%s" % int(time)

func canvasObjective():
	var _objective = objective.instance()
	_objective.layer = 2
	_objective.obj = "Encuentra los pares correctos" ### MEJORAR ESTA PARTE
	add_child(_objective)
	return _objective

func calc_columns(cant: int) -> int:
	match cant:
		2:
			return 2
		4:
			return 2
		5:
			return 2
		6:
			return 3
		8:
			return 4
		10:
			return 4
		12:
			return 4
		14:
			return 5
		16:
			return 4
		18:
			return 6
		20:
			return 5
		22:
			return 6
		24:
			return 6
		26:
			return 7
		28:
			return 7
		30:
			return 8
		32:
			return 8
		_:
			return 0

func init_game():
	cant_cards = 5 * 2
	
	var columns : int = calc_columns(cant_cards)
	var fila : int = ceil(float(cant_cards) / float(columns))
	var width_fila : int = min ((1920 - 200) / columns, (1080 -200) / fila)
	
	var width_card : int = float(width_fila / 1.25)
	
	var fila_offset : int = (width_fila - width_card)
	
	var margin_fila : int = (1920 - (width_card * columns
	+ fila_offset * (columns - 1))) / 2
	
	var lastMargin = 0

	if cant_cards % columns > 0:
		var lastEmptyF = (columns - (cant_cards % columns ))
		lastMargin = (lastEmptyF * width_fila) / 2
	
	var numero : Array = [1,2,3,4,5,6]

	var fronts : Array = []
	for i in range(floor(cant_cards / 2)):
		var front : String = "Card_"+str(numero[i])
		fronts.append(front)
		fronts.append(front+"_-")
		
	var f2 : Array = []

	while fronts.size():
		if f2.size() == 0:
			f2.append(fronts[0])
		else:
			f2.insert(randi() % (f2.size() + 1),
			fronts[0])
		fronts.remove(0)
	fronts = f2
	
	for i in range(cant_cards):
		var r = floor( i / columns)
		var c = i % columns
		var ext = 0
		
		if r == fila - 1:
			ext = lastMargin
		
		var card = cardPre.instance()
		
		card.add_to_group("carta")
		var pos_x : float = margin_fila + c * width_fila + ext
		var pos_y : float = 100 + r * width_fila
		card.globalPos(pos_x, pos_y)
		card.scale = Vector2(width_card / 252.0, width_card / 252.0)
		self.add_child(card)
		card.setFront(fronts[i])
		
		card.connect("clicked", self, "_on_clicked_card")
		card.connect("flipped", self , "_on_card_flipped")

func _on_clicked_card(card):
	if !card.is_flipped:
		card.flip_card()
		
func _on_card_flipped(card):
	if card.is_flipped:
		if up_card == null:
			up_card = card
		else:
			if up_card.id == card.id:
				up_card = null
				if _are_all_flipped():
					clear_game()
			else:
				_cards.append(up_card)
				_cards.append(card)
				timer.start()
				up_card = null

func blockCards() -> void:
	var blockedCards = _find_all_cards()
	for card in blockCards():
		card.clickable_area.waiting = not card.clickable_area.waiting


func clear_game():
	paused = true
	yield(get_tree().create_timer(1), "timeout" )
	var cards = _find_all_cards()
	while cards.size() > 0:
		cards[0].queue_free()
		cards.remove(0)
	$endGame/Panel/Puntos.text = "Completaste el memorama en %s segundos." %int(time)
	$AnimationPlayer.play("result_scrn")
	$Start.visible = false
	$TimePassed.visible = false

func _are_all_flipped() -> bool:
	for card in _find_all_cards():
		if !card.is_flipped:
			return false
	return true

func _find_all_cards() -> Array:
	var res : Array = []
	var children = self.get_children()
	for child in children:
		if child.is_in_group("carta"):
			res.append(child)
	return res
	
func finished_time():
	while _cards.size():
		var car = _cards[0]
		_cards.remove(0)
		car.reset()

func _on_Button_pressed():
	$Title.visible = false
	$Start.visible = false
	var _objective = canvasObjective()
	yield(_objective,"tree_exited")
	init_game()
	$TimePassed.visible = true
	yield(get_tree().create_timer(1),"timeout")
	paused = false


func _on_cant_card_value_changed(value):
	$Label.text = str(value)



func _on_Button2_pressed():
	$AnimationPlayer.play("result_scrn_out")
	yield(get_tree().create_timer(1),"timeout")
	queue_free()


func _on_EButton_pressed():
	time = 0
	$TimePassed.text = "Tiempo transcurrido\n%s" % int(time)
	$AnimationPlayer.play("result_scrn_out")
	$Start.visible = true


func _on_Start_pressed():
	pass # Replace with function body.
