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

export var minigame : PackedScene

onready var actions: Node = $Actions
onready var anim: AnimatedSprite = $AnimatedSprite
var frames: SpriteFrames

func _ready():
	frames = load(NPCDATABASE.get_npc(character_name).asset_folder)
	anim.set_sprite_frames(frames)
	anim.play(aniTo)

func play_minigame():
	pass

func interaction_interact(interactionComponentParent : Node) -> void:
	var actions = $Actions.get_children()
	assert(actions != [])
	for action in actions:
		action.action()
		yield(action,"finished")
	get_tree().paused = false
