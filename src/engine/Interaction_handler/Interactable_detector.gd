extends Area2D

export var interaction_parent : NodePath

signal on_interactable_changed(newInteractable)

var interaction_target : Node

func _process(delta):
	## Revisa si el jugador está intentando realizar una interacción
		if interaction_target != null and Input.is_action_just_pressed("interact") or interaction_target != null and GLOBALS.isActionButton:
			GLOBALS.isActionButton = false
			if interaction_target.has_method("interaction_interact"):
				interaction_target.interaction_interact(self)

func _on_Interactable_detector_body_entered(body):
	print("Interaction with: ",body.get_name())
	var canInteract = false
	if body.has_method("interaction_can_interact"):
		canInteract = body.interaction_can_interact(get_node(interaction_parent))
	if not canInteract:
		return
	GLOBALS.canActionButton = true
	interaction_target = body
	#body.sprite.texture = load(ItemDb.get_item(body.tipo).on_asset) ##Asset ON
	emit_signal("on_interactable_changed", interaction_target)


func _on_Interactable_detector_body_exited(body):
	GLOBALS.canActionButton = false
	#body.sprite.texture = load(ItemDb.get_item(body.tipo).asset) ##Asset ON
	if(body == interaction_target):
		interaction_target = null
		emit_signal("on_interactable_changed", null)
