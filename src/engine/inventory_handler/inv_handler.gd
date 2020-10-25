extends Node2D

var max_slots : int = 5
var items = Array()
var lastIndex = 0

func _ready():
	inicializarArray()

func inicializarArray() -> void:   ##Se inicializa el arreglo de items
	for item in range(max_slots):
		items.append(0)

func grabItem(tipo : int) -> bool:
	if lastIndex < max_slots:
		items[lastIndex] = tipo
		lastIndex += 1
		return true
	else:
		print("Inventario lleno, desecha algo en los botes correspondientes")
		return false
	
func reorganizeTest():
	items.invert()

func disposeItem(ind : int, tipo : int):
	if items[ind] == tipo:
		print("Felicidades depositaste correctamente la basura !")
	else:
		print("Uy! El residuo que depositaste no corresponde a este bote")
	items.remove(ind)
	items.append(0)
	lastIndex -= 1

func getItems() -> Array:
	return items

func getMaxSlots() -> int:
	return max_slots
