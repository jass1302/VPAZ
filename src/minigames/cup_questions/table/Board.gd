extends Node2D

onready var cups = get_node("Cups")
onready var bolitas = get_node("Bolita")
var lastPermutation: int

onready var randomizeBonusInd : Array = _randomizeBonus()

var destinos = [
				Vector2(300,750),
				Vector2(900,750),
				Vector2(1500,750)
			]
var _questions: Array
			
func _ready():
	initializeBalls()
	initializeCups()
	yield(get_tree().create_timer(1.5), "timeout")
	
	for b in bolitas.get_children():
		b.visible = false
	
	randomize()
	
	for x in range(15):
		animateCups()
		yield(get_tree().create_timer(0.3), "timeout")
	
	cups.get_child(0).uncover.disabled = false
	cups.get_child(1).uncover.disabled = false
	cups.get_child(2).uncover.disabled = false
	
	for b in bolitas.get_children():
		b.visible = true
	
	
func initializeCups() -> void:
	var i = 1
	for x in cups.get_children():
		x.setLabel(str(i))
		x.cupNumber = i
		x.questionInd = _questions[i-1]
		if randomizeBonusInd[i-1] == 1:
			x.hasBonus = true
		x.connect("finished", self, "poolEnded")
		i+=1
func _randomizeBonus() -> Array:
	var randomBonusInd = [0,0,0]
	var randomBonus = randi() % 2
	randomBonusInd[randomBonus] = 1
	return randomBonusInd

func initializeBalls() -> void:
	var ind = 0
	for i in bolitas.get_children():
		if randomizeBonusInd[ind] == 1:
			i.changeFrame()
		ind = ind + 1

func updateBallPos():
	var x = 0
	for b in bolitas.get_children():
		b.position = Vector2(destinos[x].x,b.position.y)
		x+=1
		
func updateCupPos() -> void:
	var x = 0
	for c in cups.get_children():
		c.position = destinos[x]
		x+=1
func poolEnded() -> void:
	queue_free()

func animateCups():
	var iteration: int = 0
	var rando = randi() % 6 + 1
	
	while(rando == lastPermutation):
		rando = randi() % 6 + 1
	lastPermutation = rando
	changePos(rando)

	cups.get_child(0).animationTween(cups.get_child(0).position,destinos[0])
	cups.get_child(1).animationTween(cups.get_child(1).position,destinos[1])
	cups.get_child(2).animationTween(cups.get_child(2).position,destinos[2])
	updateCupPos()
	updateBallPos()

func changePos(ind : int) -> void:
	match ind:
		1: #1,2,3
			destinos = [
				Vector2(300,750),
				Vector2(900,750),
				Vector2(1500,750)
			]
		2: #2,1,3
			destinos = [
				Vector2(900,750),
				Vector2(300,750),
				Vector2(1500,750)
			]
		3: #3,1,2
			destinos = [
				Vector2(1500,750),
				Vector2(300,750),
				Vector2(900,750)
			]
		4: #1,3,2
			destinos = [
				Vector2(300,750),
				Vector2(1500,750),
				Vector2(900,750)
			]
		5: #2,3,1
			destinos = [
				Vector2(900,750),
				Vector2(1500,750),
				Vector2(300,750)
			]
		6: #3,2,1
			destinos = [
				Vector2(1500,750),
				Vector2(900,750),
				Vector2(300,750)
			]
