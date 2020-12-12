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
		return "Busca a " + interact_with_name + " y habla con él. "
	return "Busca a " + interact_with_name + " y habla con él. (Completado)"
