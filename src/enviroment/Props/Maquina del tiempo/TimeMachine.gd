extends Interactable

func _ready():
	$CollisionPolygon2D.disabled = true
signal travel

func interaction_interact(interactionComponentParent : Node) -> void:
	if SCRSYSTEM.level1Cleared:
		emit_signal("travel")
	else:
		print("uy")

func _activateMachine() -> void:
	$CollisionPolygon2D.disabled = false
