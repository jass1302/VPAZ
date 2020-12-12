extends Control
class_name QuestUI

signal updated

onready var tree := $Column/Tree

export var active_icon: Texture
export var inactive_icon: Texture
export var completed_icon: Texture
export var objective_completed: Texture
export var objective_uncompleted: Texture

var tree_root: TreeItem
var active = false

func _ready():
	for quest in QUESTSYSTEM.getAvailableQuests():
		## Empezamos a escuchar las señales del sistema de misiones por cada 
		## misión existente en el area de "disponibles". 
		quest.connect("started", self, "_on_quest_started", [quest])
		quest.connect("completed",self, "_on_quest_completed", [quest])
		quest.connect("delivered", self, "_on_quest_delivered", [quest])
	
	tree.set_hide_root(true)
	tree_root = tree.create_item()


## La siguiente función se ejecuta cuándo se emite una señal "started" desde el
## sistema de misiones
func _on_quest_started(quest: Quest) -> void:
	var quest_root = _add_tree_item(tree_root, quest.title, active_icon, quest)
	_add_tree_item(quest_root, quest.description)
	## TODO: Agregar textos de recompensa
	## .\
	
	## Loop que agrega los objetivos
	for objective in quest.get_objectives():
		##Conectamos las señales de los objetivos para comenzar a escuchar
		objective.connect("updated", self, "_on_Objective_updated")
		objective.connect("completed", self, "_on_Objective_completed")
		print(objective.get_name())
		_add_tree_item(
			quest_root,
			objective.as_text(),
			## El siguiente texto cambia la textura de acuerdo a si está o no completado el objetivo
			objective_completed if objective._completed else objective_uncompleted,
			objective
		)
	emit_signal("updated")
	


## La siguiente función se ejecuta cuando se emite una señal "completed" desde el
## sistema de misiones
func _on_quest_completed(quest: Quest) -> void:
	var quest_item = _find_quest_tree_item(quest)
	if quest_item == null:
		return
	quest_item.set_icon(0,completed_icon)
	emit_signal("updated")

## La siguiente función se ejecuta cuando se emite una señal "delivered" desde el
## sistema de misiones
func _on_quest_delivered(quest: Quest) -> void:
	var quest_item = _find_quest_tree_item(quest)
	if quest_item == null:
		return
	quest_item.set_icon(0, inactive_icon)
	emit_signal("updated")


func _find_quest_tree_item(quest: Quest) -> TreeItem:
	var quest_item = tree_root.get_children()
	while quest_item != null:
		if quest_item.get_metadata(0) == quest:
			return quest_item
		quest_item = quest_item.get_next()
	return null


func _on_Objective_updated(objective: QuestObjective) -> void:
	var objective_item = _find_objective_tree_item(objective)
	if objective_item == null:
		return
	objective_item.set_text(0, objective.as_text())


func _on_Objective_completed(objective: QuestObjective) -> void:
	print("Am I even Here?")
	var objective_item = _find_objective_tree_item(objective)
	if objective_item == null:
		print("objective_item is null")
		return
	print(objective.as_text())
	objective_item.set_icon(0, objective_completed)
	objective_item.set_text(0, objective.as_text())

func _add_tree_item(
	root: TreeItem,
	text: String,
	icon: Texture = null,
	metadata = null,
	selectable: bool = false,
	collapsed: bool = true
	) -> TreeItem:
		var item = tree.create_item(root)
		item.set_icon(0, icon)
		item.set_text(0, text)
		item.set_selectable(0, selectable)
		item.collapsed = collapsed
		if metadata != null:
			item.set_metadata(0, metadata)
		return item

func _find_objective_tree_item(objective: QuestObjective) -> TreeItem:
	var quest_item = tree_root.get_children()
	while quest_item != null:
		var objective_item = quest_item.get_children()
		while objective_item != null:
			if(
				objective_item.get_metadata(0) != null
				and objective_item.get_metadata(0) == objective
			):
				return objective_item
			objective_item = objective_item.get_next()
		quest_item = quest_item.get_next()
	return null
