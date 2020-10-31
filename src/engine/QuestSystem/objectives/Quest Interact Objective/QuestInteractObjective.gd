extends QuestObjective
class_name QuestInteractObjective

export var interact_with: PackedScene

func _ready():
	for interactable in get_tree().get_nodes_in_group("NPC"):
		interactable.connect(
			"interaction_finished", self, "on_interactable_interaction_finished"
		)

func on_interactable_interaction_finished(npc) -> void:
	if npc.filename == interact_with.resource_path and not _completed:
		finish()
