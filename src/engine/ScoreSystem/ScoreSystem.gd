extends Node

var totalGrabbedItems : int = 0
var totalGrabbedTypeOne : int = 0
var totalGrabbedTypeTwo : int = 0
var totalGrabbedTypeThree : int = 0

## MainQuests
var level1QuestsCleared: Array = [false, false, false]
var level1Cleared: bool = false
var level2QuestsCleared: Array = [false, false, false, false]
var level2Cleared: bool = false
var level3QuestsCleared: Array = [false, false, false]
var level3Cleared: bool = false

signal mainCompleted(idQuest)
signal mainUpdated(idQuest)

##/MainQuests

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

## Rompecabezas
var isJigsawCleared: bool = false
var bestTime: int = 0
## / Rompecabezas

func _ready():
	InvHandler.connect("grabbedItem",self,"countItem")
	scores.append(0)
	scores.append(0)
	scores.append(0)
	scores.append(0)
	scores.append(0)
	scores.append(0)

func updateMainQuest(questID: String, questInd: int) -> void:
	match questID:
		"Lv1":
			level1QuestsCleared[questInd] = true
			print(level1QuestsCleared)
			emit_signal("mainUpdated",questID)
			var cleared = true
			for x in level1QuestsCleared:
				if not x:
					cleared = false
			if cleared:
				print("Nivel 1 completado")
				level1Cleared = true
				emit_signal("mainCompleted", questID)
		"Lv2":
			pass
		"Lv3":
			pass

func _clearGame(idGame: String) -> void:
	match idGame:
		"RT":
			isTrashRainCleared = true
			emit_signal("completed",idGame, null)
		"WTB":
			isWTBCleared = true
			emit_signal("completed", idGame, null)
		"Jigsaw":
			isJigsawCleared = true
			print("Completaste al menos un rompecabezas en un tiempo de %s segundos" %bestTime)
			emit_signal("completed", idGame, null)

func _updateMiniGame(idGame: String, data: Array) -> void:
	match idGame:
		"RT": ## Rain Trash
			clearedPhases = data[0]
			if data[1] > scores[data[0] - 1]:
				scores[data[0] - 1] = data[1]
				emit_signal("update", idGame, data)
		"WTB": ## ¿Donde está la bolita?
			if data[0] > highest_ScoreWTB:
				highest_ScoreWTB = data[0]
				emit_signal("update", idGame, data)
		"Jigsaw":
			bestTime = data[0]
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
