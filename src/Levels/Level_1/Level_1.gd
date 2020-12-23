extends Node
onready var parent: Node2D
onready var level: Node2D = get_node("LevelMap")

export var quest_1: PackedScene 
var test_quest

func _ready():
	_firstArrival()
	
func _firstArrival() -> void:
	yield(get_tree().create_timer(0.35),"timeout")
	test_quest = QUESTSYSTEM.getQuestAvaible(quest_1.instance())
	QUESTSYSTEM.start(test_quest)
