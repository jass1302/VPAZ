extends Resource

## General Stuff
export(String) var username: String
export(bool) var tutorialsEnabled: bool = true
export(String,"Seleccionar", "Male", "Female") var gender
export(String) var profileIcon: String
export(Array) var clearedLevels: Array
export(Array) var obtainedBadges: Array
export(int) var tempCoins: int
export(int) var SFXVolume: int
export(int) var BGMVolume: int

## --------------------  QuestData ------------------------------------------ ##
export(Dictionary) var questProgress

## ------------- Scoredata ---------------------------------------------------##
export(int) var totalGrabbedItems : int
export(int) var totalGrabbedTypeOne : int
export(int) var totalGrabbedTypeTwo : int
export(int) var totalGrabbedTypeThree : int

## MainQuests
export(Array) var level1QuestsCleared: Array
export(bool) var level1Cleared: bool
export(Array) var level2QuestsCleared: Array
export(bool) var level2Cleared: bool
export(Array) var level3QuestsCleared: Array
export(bool) var level3Cleared: bool


## Lluvia de basura
export(bool) var isTrashRainCleared: bool
export(int) var highestScoreRainCleared: int
export (int) var clearedPhases: int
export(Array) var scores: Array
## / Lluvia de basura

## Dónde está bolita?
export(bool) var isWTBCleared: bool
export(int) var lastAmountQuestions: int
export(int) var highest_ScoreWTB: int
## / Dónde está bolita?

## Rompecabezas
export(bool) var isJigsawCleared: bool
export(int) var bestTime: int = 0
## / Rompecabezas

##   PipeGame
export(bool) var isPipeGameCleared: bool = false
## / PipeGame


## -------------------------------------------------------------------------- ##
