extends Interactable
class_name non_playable_character
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
	) var character_name

export( String,"Seleccionar","N","NE","NO", "E", "O", "S", "SE", "SO") var aniTo

onready var actions: Node = $Actions
onready var anim: AnimatedSprite = $AnimatedSprite
onready var bubble: Node = $QuestIndicator
var frames: SpriteFrames


signal interaction_finished(character_name)

func _ready():
	frames = load(NPCDATABASE.get_npc(character_name).asset_folder)
	anim.set_sprite_frames(frames)
	anim.play(aniTo)
	
	# Quests
	# Send quest-related MapActions, if any, to the QuestBubble
	var quest_actions: Array = []
	for action in actions.get_children():
		if not (action is GiveQuestAction or action is CompleteQuestAction):
			continue
		quest_actions.append(action)
	if quest_actions.size() == 0:
		return
	bubble.initialize(quest_actions)
	print(actions.get_parent().get_path())

func save() -> Dictionary:
	var save_dic = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
	}
	return save_dic

func interaction_interact(interactionComponentParent : Node) -> void:
	## Se pausa la física del jugador
	GLOBALS.overPlayer._pause_player()
	## Se oculta la interfaz gráfica del juego para un aspecto limpio que no entre en conflicto
	## Con los dialogos o minijuegos que se encuentran en pantalla
	GLOBALS.hide_ui()
	## Se instancia un arreglo temporal, donde se guardan todas las acciones ligadas al NPC
	var actions = $Actions.get_children()
	## Se revisa que el nodo de acciones no se encuentre vacío
	if actions != []:
		## De no estar vacio, se itera uno por uno
		for action in actions:
			## Se ejecuta el método de acción ligado a la clase de actions
			action.action()
			## Con yield nos aseguramos que el ciclo no siga hasta que la acción ejecutada
			## sea finalizada
			yield(action,"finished")
		
		## Una vez que el ciclo for es terminado, se emite una señal "interaction_finished"
		## indicando así que el jugador terminó de interactuar con este NPC
		emit_signal("interaction_finished", character_name)

	## Reanudamos las físicas del jugador en el nivel
	GLOBALS.overPlayer._pause_player()
	## Volvemos a mostrar la interfaz gráfica del nivel
	GLOBALS.show_ui()
