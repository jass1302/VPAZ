extends Interactable

## Bandera para saber si el jugador puede tirar objetos
var canDispose : bool = false 
## Se instancia la escena que hace referencia al UI para tirar objetos del inventario
var DisposeScene = preload("res://objects/deposit/DepositUI.tscn").instance()

onready var sprite = $Sprite
var frames : SpriteFrames
var aux
var trashCanType : int = 1
export(String, "Seleccionar", "Orgánico", "Inorgánico", "Papel", "Metal", "Vidrio", "Plástico") var listType
export(String, "Seleccionar", "_D", "_I") var orientation_texture

func _ready():
	toType(listType)
	frames = load(ItemDb.get_item("trashcan").tipo[listType].asset)
	sprite.set_sprite_frames(frames)
	sprite.play("Idle"+orientation_texture)

# By default interactable items are only availble to the Player class
func interaction_can_interact(interactionComponentParent : Node) -> bool:
	aux = interactionComponentParent
	return interactionComponentParent is Player
func toType(inType: String) -> void:
	match inType:
		"Seleccionar":
			print("No seteaste el tipo del bote de basura")
		"Orgánico":
			trashCanType = 1
		"Inorgánico":
			trashCanType = 2
		"Papel":
			trashCanType = 3
		"Metal":
			trashCanType = 4
		"Vidrio":
			trashCanType = 5
		"Plástico":
			trashCanType = 6

func closeWindow() -> void:
	aux.paused = false
	aux.set_physics_process(true)
	## De lo contrario significa que la interfaz ya estaba en pantalla
	## la bandera pasa a ser falsa y quitamos el nodo de la interfaz de tirar objetos
	DisposeScene.onScreen = false
	self.remove_child(DisposeScene)

func interaction_interact(interactionComponentParent : Node) -> void:
	## De teclearse la acción "pick" mientras que el jugador está frente a un bote de basura
			
	## Se revisa si la interfaz para para tirar objetos no este en pantalla.
	if not DisposeScene.onScreen:
		## De no estarlo, cambiamos la bandera a verdadero y agregamos el nodo de la interfaz
		## para tirar objetos, indicando, que ahora está en pantalla.
		GLOBALS.canActionButton = not GLOBALS.canActionButton 
		DisposeScene.onScreen = true
		DisposeScene.tipo = trashCanType
		DisposeScene.updateUI()
		DisposeScene.trashAX = self
		add_child(DisposeScene)
		aux.set_physics_process(false)
		aux.paused = true
	else:
		closeWindow()
