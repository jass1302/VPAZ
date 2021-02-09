extends Interactable

func _ready():
	$CollisionPolygon2D.disabled = true
signal travel

func interaction_interact(interactionComponentParent : Node) -> void:
	if SCRSYSTEM.level1Cleared and ProfileManager.currentLevel == "lv1":
		emit_signal("travel")
	if SCRSYSTEM.level2Cleared and ProfileManager.currentLevel == "lv2":
		emit_signal("travel")
	if SCRSYSTEM.level3Cleared and ProfileManager.currentLevel == "lv3":
		emit_signal("travel")
	else:
		for x in get_tree().get_nodes_in_group("coinCount"):
			x.wrongAni()
	
func _activateMachine() -> void:
	$CollisionPolygon2D.disabled = false
