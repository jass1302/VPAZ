extends Node
onready var parent: Node2D
onready var level: Node2D = get_node("LevelMap")

export var quest_1: PackedScene
var main_quest

func _ready():
	ProfileManager.currentLevel = "lv1"
	GLOBALS.initVolumeAudio()
	$AudioStreamPlayer.play()
	if not ProfileManager.lv1FirstVisited: _firstArrival()
	else: ProfileManager.restoreQuestProgress()
	$"LevelMap/Layer 3/Characters/Spawn/TimeMachine/".connect("travel", self, "_changeLevel")
	
func _firstArrival() -> void:
	yield(get_tree().create_timer(0.15),"timeout")
	main_quest = QUESTSYSTEM.getQuestAvaible(quest_1.instance())
	QUESTSYSTEM.start(main_quest)
	ProfileManager.lv1FirstVisited = true
	ProfileManager.storeData()
	yield(get_tree().create_timer(1.15),"timeout")
	$LevelMap/in.action()

func _changeLevel() -> void:
	ProfileManager.storeData()
	$AnimationPlayer.play("fadeout")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Levels/Level_2/Level_2.tscn")


func _on_ViewPoint_body_entered(body):
	if body is Player:
		$Bufa/Bufa/Camera2D.make_current()
		$AnimationPlayer.play("BufaCard")
		GLOBALS.hide_ui()


func _on_ViewPoint_body_exited(body):
	if body is Player:
		body.changeCameraScope(false)
		$AnimationPlayer.play_backwards("BufaCard")
		GLOBALS.show_ui()


func _on_ViewPointUPIIZ_body_entered(body):
	if body is Player:
		$LevelMap/UPIIZLAYER/UPIIZ/Camera2D.make_current()
		$AnimationPlayer.play("UpiizCard")
		GLOBALS.hide_ui()


func _on_ViewPointUPIIZ_body_exited(body):
	if body is Player:
		body.changeCameraScope(false)
		$AnimationPlayer.play_backwards("UpiizCard")
		GLOBALS.show_ui()
