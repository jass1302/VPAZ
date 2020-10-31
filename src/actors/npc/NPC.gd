extends Interactable
onready var actions: Node = $Actions

func interaction_interact(interactionComponentParent : Node) -> void:
	
	get_parent().add_child(load("res://ui/Dialog/Dialog.tscn").instance())
	get_tree().paused = true
	var actions = $Actions.get_children()
	
	assert(actions != [])
	
	for action in actions:
		action.action()
		yield(action,"finished")
