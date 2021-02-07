extends Node2D

func _ready():
	pass
export(Script) var saveFile
var x: Dictionary
export var username: String
var tutorialsEnabled: bool = true
export(String,"Seleccionar", "Male", "Female") var gender
var profileIcon: String = "Perrito"
var clearedLevels: Array = [false, false, false]
var obtainedBadges: Array = [
	false, false, false, false,
	false, false, false, false, false,
	false, false, false, false, false]
var tempCoins: int = 0
var SFXVolume: int = -15
var BGMVolume: int = -15

func getUsername() -> String: return username
func getGender() -> String: return gender


func _collectQuestsProgress() -> void:
	## var d = {"name": "John", "age": 22} # Simple syntax.
	## print("Name: ", d["name"], " Age: ", d["age"])
	var questDict
	var availablesDict
	var activesDict
	var completedDict
	var deliveredDict
	
	## Get AvailableQuests
	for av in QUESTSYSTEM.getAvailableQuests():
		
		pass
	var questProgressDict = {
		"availables": availablesDict,
		"actives": activesDict,
		"completed": completedDict,
		"delivered": deliveredDict
	}

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
	print("SAVED")
