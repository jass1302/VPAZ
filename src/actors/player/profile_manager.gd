extends Node2D

export(Script) var saveFile
var currentLevel: String
export var username: String
var tutorialsEnabled: bool = true
export(String,"Seleccionar", "Male", "Female") var gender
var profileIcon: String = "Perrito"
var lv1FirstVisited: bool = false
var lv2FirstVisited: bool = false
var lv3FirstVisited: bool = false
var clearedLevels: Array = [false, false, false]
var obtainedBadges: Array = [
	false, false, false, false,
	false, false, false, false, false,
	false, false, false, false, false]
var tempCoins: int = 0
var SFXVolume: int = -15
var BGMVolume: int = -15
var questProgress: Dictionary

func getUsername() -> String: return username
func getGender() -> String: return gender

func restoreQuestProgress() -> void:
	var quests = QUESTSYSTEM.getAvailableQuests()

	## Restore actives
	for reactive in questProgress["actives"]:
		for x in quests:
			if x.title == reactive[0]:
				QUESTSYSTEM.reStart(reactive[0])
				match reactive[2]:
					"main1":
						for c in SCRSYSTEM.level1QuestsCleared:
							if c: emit_signal("mainUpdated","Lv1")
					"main2":
						for c in SCRSYSTEM.level2QuestsCleared:
							if c: emit_signal("mainUpdated","Lv2")
					"main3":
						for c in SCRSYSTEM.level2QuestsCleared:
							if c: emit_signal("mainUpdated","Lv3")
	## Restores completed
	for preComplete in questProgress["completed"]:
		for x in quests:
			if x.title == preComplete[0]:
				QUESTSYSTEM.preFinish(preComplete[0])
	storeData()

func _collectQuestsProgress() -> Dictionary:
	var questDict
	var availablesDict: Array = []
	var activesDict: Array = []
	var completedDict: Array = []
	var deliveredDict: Array = []
	
	## Store AvailableQuests
	for av in QUESTSYSTEM.getAvailableQuests():
		var row = []
		row.append(av.title)
		row.append(av.questNumber)
		row.append(av.idQuest)
		availablesDict.append(row)
	#print(availablesDict)
	##../
	
	## Store ActiveQuests
	for av in QUESTSYSTEM.getActiveQuests():
		var row = []
		row.append(av.title)
		row.append(av.questNumber)
		row.append(av.idQuest)
		activesDict.append(row)
	#print(activesDict)
	##../
	
	## Store CompletedQuests
	for av in QUESTSYSTEM.getCompletedQuests():
		var row = []
		row.append(av.title)
		row.append(av.questNumber)
		row.append(av.idQuest)
		completedDict.append(row)
	#print(completedDict)
	##../
	
	## Store DeliveredQuests
	for av in QUESTSYSTEM.getDeliveredQuests():
		var row = []
		row.append(av.title)
		row.append(av.questNumber)
		row.append(av.idQuest)
		deliveredDict.append(row)
	#print(deliveredDict)
	##../

	var questProgressDict = {
		"availables": availablesDict,
		"actives": activesDict,
		"completed": completedDict,
		"delivered": deliveredDict
	}
	#print(questProgressDict)
	return questProgressDict

func storeData() -> void:
	var new_save = saveFile.new()
	print(username)
	##Profile Stuff
	new_save.username = username
	new_save.tutorialsEnabled = tutorialsEnabled
	new_save.gender = gender
	new_save.profileIcon = profileIcon
	new_save.clearedLevels = clearedLevels
	new_save.obtainedBadges = obtainedBadges
	new_save.tempCoins = tempCoins
	new_save.SFXVolume = SFXVolume
	new_save.BGMVolume = BGMVolume
	new_save.lv1FirstVisited = lv1FirstVisited
	new_save.lv2FirstVisited = lv2FirstVisited
	new_save.lv3FirstVisited = lv3FirstVisited
	
	## QuestData
	new_save.questProgress = _collectQuestsProgress()
	## ...
	## ScoreData
		##Placeholder
	new_save.totalGrabbedItems = SCRSYSTEM.totalGrabbedItems
	new_save.totalGrabbedTypeOne = SCRSYSTEM.totalGrabbedTypeOne
	new_save.totalGrabbedTypeTwo = SCRSYSTEM.totalGrabbedTypeTwo
	new_save.totalGrabbedTypeThree = SCRSYSTEM.totalGrabbedTypeThree
		## /.
	new_save.level1QuestsCleared = SCRSYSTEM.level1QuestsCleared
	new_save.level1Cleared = SCRSYSTEM.level1Cleared
	new_save.level2QuestsCleared = SCRSYSTEM.level2QuestsCleared
	new_save.level2Cleared = SCRSYSTEM.level2Cleared
	new_save.level3QuestsCleared = SCRSYSTEM.level3QuestsCleared
	new_save.level3Cleared = SCRSYSTEM.level3Cleared
	
	
	ResourceSaver.save("user://_saves//save.tres", new_save)

func loadData():
	var dir = Directory.new()
	if not dir.file_exists("user://_saves//save.tres"):
		return false
	var saveLoad = load("user://_saves//save.tres")
	##Verificar archivo
	##..
	username = saveLoad.username
	tutorialsEnabled = saveLoad.tutorialsEnabled
	gender = saveLoad.gender
	profileIcon = saveLoad.profileIcon
	clearedLevels = saveLoad.clearedLevels
	obtainedBadges = saveLoad.obtainedBadges
	tempCoins = saveLoad.tempCoins
	SFXVolume = saveLoad.SFXVolume
	BGMVolume = saveLoad.BGMVolume
	lv1FirstVisited = saveLoad.lv1FirstVisited
	lv2FirstVisited = saveLoad.lv2FirstVisited
	lv3FirstVisited = saveLoad.lv3FirstVisited
	## Quest Progress
	questProgress = saveLoad.questProgress
	## Score Data
		## ScoreData
		##Placeholder
	SCRSYSTEM.totalGrabbedItems = saveLoad.totalGrabbedItems
	SCRSYSTEM.totalGrabbedTypeOne = saveLoad.totalGrabbedTypeOne
	SCRSYSTEM.totalGrabbedTypeTwo = saveLoad.totalGrabbedTypeTwo
	SCRSYSTEM.totalGrabbedTypeThree = saveLoad.totalGrabbedTypeThree
		## /.
	SCRSYSTEM.level1QuestsCleared = saveLoad.level1QuestsCleared
	SCRSYSTEM.level1Cleared = saveLoad.level1Cleared
	SCRSYSTEM.level2QuestsCleared = saveLoad.level2QuestsCleared
	SCRSYSTEM.level2Cleared = saveLoad.level2Cleared
	SCRSYSTEM.level3QuestsCleared = saveLoad.level3QuestsCleared
	SCRSYSTEM.level3Cleared = saveLoad.level3Cleared
	
