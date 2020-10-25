extends Interactable

export var tipo = 0
var canPicked = false
onready var sprite = $Sprite

func _ready():
	sprite.texture = load(ItemDb.get_item(tipo).asset)


func interaction_interact(interactionComponentParent : Node) -> void:
	if InvHandler.grabItem(tipo):
		print("¡A la bolsa!")
		print(InvHandler.getItems())
		queue_free()
