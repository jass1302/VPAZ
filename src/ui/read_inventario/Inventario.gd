extends CanvasLayer

var items = "MarginContainer/VBoxContainer/HBoxContainer"
var onScrn : bool = false


func _ready():
	inicializarInventario()

func setInventario() -> void:
	var i : int = 0
	for item in InvHandler.getItems():
		get_node(items).get_child(i).texture = load(ItemDb.get_item(item).asset)
		i+=1
	
func inicializarInventario() -> void:
	var auxNode : TextureRect
	if get_node(items).get_child_count() < InvHandler.getMaxSlots():
		var i : int = 0
		while( i < InvHandler.getMaxSlots()):
			auxNode = TextureRect.new()
			## Inicializamos la UI con la textura del item vacio
			auxNode.texture = load(ItemDb.get_item(0).asset)  
			get_node(items).add_child(auxNode)
			i += 1
	setInventario()
