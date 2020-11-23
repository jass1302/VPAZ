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
	"Jose Luis",
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


func interaction_interact(interactionComponentParent : Node) -> void:
	get_tree().paused = true
	var actions = $Actions.get_children()
	assert(actions != [])
	for action in actions:
		action.action()
		yield(action,"finished")
	get_tree().paused = false
