extends Interactable

func _ready():
	$CollisionPolygon2D.disabled = true
	pass

func interaction_interact(interactionComponentParent : Node) -> void:
	print("andachaval")

func _activateMachine() -> void:
	$CollisionPolygon2D.disabled = false
