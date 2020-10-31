extends Node2D

var max_slots : int = 6
var items = Array()
var lastIndex = 0

signal grabbedItem
signal fullInventory

func _ready():
	inicializarArray()

func inicializarArray() -> void:   ##Se inicializa el arreglo de items
	for item in range(max_slots):
		items.append(0)

func grabItem(tipo : int) -> bool:
	if lastIndex < max_slots:
		items[lastIndex] = tipo
		lastIndex += 1
		emit_signal("grabbedItem",tipo)
		return true
	else:
		print("Inventario lleno, desecha algo en los botes correspondientes")
		return false
	
func reorganizeTest():
	items.invert()

func disposeItem(ind : int, tipo : int):
	var dialogDispose = preload("res://ui/Dialog/Dialog.tscn").instance()
	var dialog = []
	if items[ind] == tipo:
		dialog = [
			'¡Así se hace! Depositaste correctamente el residuo.'
		]
		dialogDispose.get_node("CanvasLayer/DialogBox").setDialog(dialog)
	else:
		dialog = [
			'Parece que te equivocaste, este residuo no iba aquí.'
		]
		dialogDispose.get_node("CanvasLayer/DialogBox").setDialog(dialog)
	dialogDispose.get_node("CanvasLayer").layer = 2
	items.remove(ind)
	items.append(0)
	lastIndex -= 1
	get_parent().add_child(dialogDispose)

func getItems() -> Array:
	return items

func getMaxSlots() -> int:
	return max_slots
