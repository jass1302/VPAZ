extends Node
class_name scoreData

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
var jigBestTime: int = 0
## / Rompecabezas

##   PipeGame
var isPipeGameCleared: bool = false
## / PipeGame

## Memorama
var isMemoCleared: bool = false
var memoBestTime: int = 0
## / Memorama

## TreeGame / Árbol que nace torcido...
var isTreeGameCleared: bool = false
## / TreeGame

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
			emit_signal("mainUpdated",questID)
			var cleared = true
			for x in level1QuestsCleared:
				if not x:
					cleared = false
			if cleared:
				level1Cleared = true
				emit_signal("mainCompleted", questID)
		"Lv2":
			level2QuestsCleared[questInd - 3] = true
			emit_signal("mainUpdated",questID)
			var cleared = true
			for x in level2QuestsCleared:
				if not x:
					cleared = false
			if cleared:
				level2Cleared = true
				emit_signal("mainCompleted", questID)
		"Lv3":
			level3QuestsCleared[questInd - 7] = true
			emit_signal("mainUpdated",questID)
			var cleared = true
			for x in level3QuestsCleared:
				if not x:
					cleared = false
			if cleared:
				level3Cleared = true
				emit_signal("mainCompleted", questID)

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
			emit_signal("completed", idGame, null)
		"Pipes":
			isPipeGameCleared = true
			emit_signal("completed", idGame, null)
		"Memorama":
			isMemoCleared = true
			emit_signal("completed", idGame, null)
		"TreeGame":
			isTreeGameCleared = true
			emit_signal("completed", idGame, null)
		"Fishing":
			pass # Pesca
		"Waldo":
			pass #OntaElAnimal
		"JumpyBird":
			pass ## Flying Bird
		"JumpyBird2":
			pass ## Runner

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
			jigBestTime = data[0]
			emit_signal("update", idGame, data)
		"Pipes": ## Nada que actualizar
			pass
		"Memorama":
			memoBestTime = data[0]
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
