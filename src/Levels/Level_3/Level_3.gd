extends Node

export var quest_1: PackedScene
var main_quest

func _ready():
	
	ProfileManager.currentLevel = "lv3"
	GLOBALS.initVolumeAudio()
	$LevelMap/Layer3/Spawn/TimeMachine.connect("travel", self, "_changeLevel")
	if not ProfileManager.lv3FirstVisited: _firstArrival()
	else: ProfileManager.restoreQuestProgress()

func _firstArrival() -> void:
	ProfileManager.lv3FirstVisited = true
	#ProfileManager.restoreQuestProgress()
	yield(get_tree().create_timer(0.15),"timeout")
	main_quest = QUESTSYSTEM.getQuestAvaible(quest_1.instance())
	QUESTSYSTEM.start(main_quest)
	ProfileManager.storeData()

func _changeLevel() -> void:
	ProfileManager.storeData()
	$AnimationPlayer.play("fadeout")
	yield($AnimationPlayer,"animation_finished")
	## Cinematica final
	get_tree().change_scene("res://Levels/Level_3/Level_3.tscn")
