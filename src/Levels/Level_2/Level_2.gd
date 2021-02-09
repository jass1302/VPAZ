extends Node

onready var characters_node: YSort = get_node("LevelMap/Layer_3/Characters")
onready var scenePlayer: Player  = get_node("LevelMap/Layer_3/Spawn/player")

onready var startSpawn: Position2D = get_node("LevelMap/Layer_3/Spawn/Spawn")
onready var endSpawn: Position2D = get_node("LevelMap/Layer_3/Spawn/Spawn2")
# Called when the node enters the scene tree for the first time.

export var quest_1: PackedScene
var main_quest

func _ready():
	ProfileManager.currentLevel = "lv2"
	GLOBALS.initVolumeAudio()
	$LevelMap/Layer_3/Spawn/TimeMachine.connect("travel", self, "_changeLevel")
	if not ProfileManager.lv2FirstVisited: _firstArrival()
	else: ProfileManager.restoreQuestProgress()

func _firstArrival() -> void:
	ProfileManager.lv2FirstVisited = true
	ProfileManager.restoreQuestProgress()
	yield(get_tree().create_timer(0.15),"timeout")
	main_quest = QUESTSYSTEM.getQuestAvaible(quest_1.instance())
	QUESTSYSTEM.start(main_quest)
	ProfileManager.storeData()

func _changeLevel() -> void:
	ProfileManager.storeData()
	$AnimationPlayer.play("fadeout")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Levels/Level_3/Level_3.tscn")
