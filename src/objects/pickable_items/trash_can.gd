extends Interactable

## Bandera para saber si el jugador puede tirar objetos
var canDispose : bool = false 
## Se instancia la escena que hace referencia al UI para tirar objetos del inventario
var DisposeScene = preload("res://objects/deposit/DepositUI.tscn").instance()
var tipo = 4
onready var sprite = $Sprite
##
var aux

##
export var trashCanType : int = 1

func _ready():
	match trashCanType:
		1: $Sprite.self_modulate = Color.red
		2: pass
		3: $Sprite.self_modulate = Color.blue

# By default interactable items are only availble to the Player class
func interaction_can_interact(interactionComponentParent : Node) -> bool:
	aux = interactionComponentParent
	return interactionComponentParent is Player

func interaction_interact(interactionComponentParent : Node) -> void:
	## De teclearse la acción "pick" mientras que el jugador está frente a un bote de basura
			
	## Se revisa si la interfaz para para tirar objetos no este en pantalla.
	if not DisposeScene.onScreen:
		## De no estarlo, cambiamos la bandera a verdadero y agregamos el nodo de la interfaz
		## para tirar objetos, indicando, que ahora está en pantalla. 
		DisposeScene.onScreen = true
		DisposeScene.tipo = trashCanType
		DisposeScene.updateUI()
		add_child(DisposeScene)
		aux.set_physics_process(false)
		aux.paused = true
	else:
		aux.paused = false
		aux.set_physics_process(true)
		## De lo contrario significa que la interfaz ya estaba en pantalla
		## la bandera pasa a ser falsa y quitamos el nodo de la interfaz de tirar objetos
		DisposeScene.onScreen = false
		self.remove_child(DisposeScene)
