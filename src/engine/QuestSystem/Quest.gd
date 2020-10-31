extends Node

class_name Quest

signal started
signal completed
signal delivered

onready var objectives = $Objectives

export var title: String
export var description: String

export var reward_on_delivery: bool = false
export var _reward_experience: int
onready var _reward_items: Node = $Rewards

func _start():
	for objective in get_objectives():
		objective.connect("completed",self, "_on_Objective_completed")
		objective.connect_signals()
	print("Mission Started")
	emit_signal("started")

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
	if get_completed_objectives().size() == get_objectives().size():
		print("Mision completada")
		emit_signal("completed")
		
func _deliver():
	emit_signal("delivered")
