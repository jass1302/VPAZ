extends Node
 
##

##

onready var available_quests = $Available
onready var active_quests = $Actives
onready var delivered_quests = $Delivered
onready var completed_quests = $Completed

var _player: Player
	
func _initialize(game, player: Player) -> void:
	## game.connect se conectan las señales que el sistema escuchará
	_player = player

func getQuestAvaible(ref: Quest) -> Quest:
	## Regresa la misión correspondiente a la referencia recibida
	##
	return available_quests.find_quest(ref)

func is_completed(ref: Quest) -> bool:
	if ref == null:
		return false
	return completed_quests.find_quest(ref) != null
	
func getAvailableQuests() -> Array:
	return available_quests.get_quests()

func is_available(ref: Quest) -> bool:
	return available_quests.find_quest(ref) != null

func start(ref: Quest):
	var quest: Quest = available_quests.find_quest(ref)
	quest.connect("completed",self,"_on_Quest_completed",[quest])
	available_quests.remove_child(quest)
	active_quests.add_child(quest)
	quest._start()

func _on_Quest_completed(quest):
	active_quests.remove_child(quest)
	completed_quests.add_child(quest)
	print(quest)

func deliver(quest: Quest):
	## Marca la misión como completada y recompensa al jugador
	## Y la elimina de la lista de misiones completadas
	quest._deliver()
	## Recompensas de jugador
	##TODO: Programar recompensas
	
	## Añadir luego
	
	assert(quest.get_parent() == completed_quests)
	completed_quests.remove_child(quest)
	delivered_quests.add_child(quest)
