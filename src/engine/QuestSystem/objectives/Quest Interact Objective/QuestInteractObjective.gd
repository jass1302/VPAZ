extends QuestObjective
class_name QuestInteractObjective
export (
	String,
	"Seleccionar", 
	"Carlos", 
	"Cartero",
	"Cientifica",
	"Cientifico",
	"Claudia", 
	"Daniel",
	"Elizabeth",
	"Horm",
	"José Luis",
	"José",
	"Juan Carlos",
	"Minero",
	"NPC-Niña",
	"PoliciaF",
	"PoliciaM",
	"Presidente",
	"Señor corbata",
	"Señora",
	"Señorita",
	"TecConafor",
	"TecJiapaz"
	) var interact_with_name
export var objective_description: String

func connect_signals() -> void:
	for interactable in get_tree().get_nodes_in_group("npc_character"):
		interactable.connect(
			"interaction_finished", self, "on_interactable_interaction_finished"
		)
		
func on_interactable_interaction_finished(npc_name) -> void:
	if npc_name == interact_with_name and not _completed:
		finish()

func as_text() -> String:
	if not _completed:
		return objective_description
	return objective_description+" (Completado)"
