extends Node
class_name Quest

## Se instancian tres señales
signal started
signal completed
signal delivered

onready var objectives = $Objectives

export var title: String	## Titulo de la misión
export var description: String ## Descripción de la misión
export (String,
	"Seleccionar",
	"main1",
	"main2",
	"main3",
	"Lv1",
	"Lv2",
	"Lv3"
	) var idQuest
export var questNumber: int
export var firstQuest: PackedScene
var oneQuest
export var reward_on_delivery: bool = false		## La misión dará recompensa al ser completada. 
export var _reward_experience: int				## Cantidad de experiencia que recompensará 
onready var _reward_items: Node = $Rewards		## Recompensas / Medallas	

func _start():									## Esta función inicia la misión
	for objective in get_objectives():			## Se itera en los objetivos de la misión
		objective.connect("completed",self, "_on_Objective_completed")	## Y se comienzan a escuchar las señales de compleción de cada objetivo.
		objective.connect_signals()
	print("- - - Misión %s iniciada- - - " % title)
	emit_signal("started")		## Se emite una señal de inicio de misión
	if idQuest == "main1" or idQuest == "main2" or idQuest == "main3":
		if idQuest == "main1" and ProfileManager.lv1FirstVisited: return
		if idQuest == "main2" and ProfileManager.lv2FirstVisited: return
		if idQuest == "main3" and ProfileManager.lv3FirstVisited: return
		yield(get_tree().create_timer(0.3),"timeout")
		oneQuest = QUESTSYSTEM.getQuestAvaible(firstQuest.instance())
		QUESTSYSTEM.start(oneQuest)
	ProfileManager.storeData()

func get_objectives():
	return objectives.get_children()

func get_completed_objectives():
	var completed: Array = []
	for objective in get_objectives():
		if not objective._completed:
			continue
		completed.append(objective)
	return completed
	
func _on_Objective_completed(objective) -> void:
	print("Completed: "+objective.get_name())
	if get_completed_objectives().size() == get_objectives().size():
		print("- - - Mision %s completada - - -" %title)
		if idQuest == "Lv1" or idQuest == "Lv2" or idQuest == "Lv3":
			SCRSYSTEM.updateMainQuest(idQuest, questNumber)
			ProfileManager.obtainedBadges[questNumber] = true
		emit_signal("completed")
		ProfileManager.storeData()

func _deliver():
	emit_signal("delivered")
