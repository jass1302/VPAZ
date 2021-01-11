extends Interactable

func _ready():
	$CollisionPolygon2D.disabled = true
signal travel

func interaction_interact(interactionComponentParent : Node) -> void:
	if SCRSYSTEM.level1Cleared:
		emit_signal("travel")
	else:
		pass

func _activateMachine() -> void:
	$CollisionPolygon2D.disabled = false
