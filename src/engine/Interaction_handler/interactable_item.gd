extends Node
class_name Interactable

func interaction_can_interact(interactionParent : Node) -> bool:
	print("aaaaaaaaa")
	return interactionParent is Player
