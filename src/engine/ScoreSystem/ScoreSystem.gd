extends Node

var totalGrabbedItems : int = 0
var totalGrabbedTypeOne : int = 0
var totalGrabbedTypeTwo : int = 0
var totalGrabbedTypeThree : int = 0

## Minigames_signals
signal completed(idGame, data)
signal update(idGame, data)

## Lluvia de basura
var isTrashRainCleared: bool = false
var highestScoreRainCleared: int = 0
var clearedPhases: int = 0
var scores: Array = []
## / Lluvia de basura

## Dónde está bolita?
var isWTBCleared: bool = false
var lastAmountQuestions: int = 0
var highest_ScoreWTB: int = 0
## / Dónde está bolita?

func _ready():
	InvHandler.connect("grabbedItem",self,"countItem")
	scores.append(0)
	scores.append(0)
	scores.append(0)
	scores.append(0)
	scores.append(0)
	scores.append(0)

func _clearGame(idGame: String) -> void:
	match idGame:
		"RT":
			isTrashRainCleared = true
			emit_signal("completed",idGame, null)
			print("emitted")

func _updateMiniGame(idGame: String, data: Array) -> void:
	match idGame:
		"RT": ## Rain Trash
			clearedPhases = data[0]
			if data[1] > scores[data[0] - 1]:
				scores[data[0] - 1] = data[1]
				emit_signal("update", idGame, data)

func countItem(tipo):
	totalGrabbedItems += 1
	match tipo:
		1:
			totalGrabbedTypeOne += 1
		2:
			totalGrabbedTypeTwo += 1
		3:
			totalGrabbedTypeThree += 1

func getTotalGrabbed() -> int:
	return totalGrabbedItems

func getTotalGrabbedOne() -> int:
	return totalGrabbedTypeOne

func getTotalGrabbedTwo() -> int:
	return totalGrabbedTypeTwo

func getTotalGrabbedThree() -> int:
	return totalGrabbedTypeThree
