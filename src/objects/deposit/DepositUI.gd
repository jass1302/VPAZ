extends Control


## Variables
## Slots maximos según el inventario.
var maxSlots = InvHandler.getMaxSlots()  

var tipo

## Panel donde se dibujarán los slots del inventario
onready var slotsPanel = get_node("CanvasLayer/Inventory") 

## Indica si la escena está en pantalla o no.
var onScreen : bool = false 

## Puntos de "drop"
var restpoint = preload("res://objects/deposit/slot/dropZone.tscn")

## Objetos seleccionables
var item = preload("res://objects/deposit/slot/Draggable_item.tscn")

## Coordenadas de los slots
var slot_sizeX
var slot_sizeY
var center

##
var ax = []
var trashAX

 
# Called when the node enters the scene tree for the first time.
func _ready():
	drawLoop()

func updateUI():
	var i : int  = 0
	for it in ax:
		it.setTexture(InvHandler.getItems()[i])
		it.ind = i
		i+=1

func calc():
	print(maxSlots)
	slot_sizeX = slotsPanel.rect_size.x / maxSlots
	slot_sizeY = slotsPanel.rect_size.y / 2
	center = slot_sizeX / 2
	
func drawRestPoint():
	var rest_point = restpoint.instance()
	rest_point.position.x = center
	rest_point.position.y = slot_sizeY
	slotsPanel.add_child(rest_point)
	
func drawItems(i : int):
	var auxItem = item.instance()
	auxItem.setTexture(InvHandler.getItems()[i])
	auxItem.ind = i
	slotsPanel.add_child(auxItem)
	ax.append(auxItem)

func setNodes():
	var ind : int
	for aux in ax:
		aux.setRestNodes(ind)
		aux.startNode = true
		ind += 1
	
func drawLoop():
	calc()
	var i : int = 0
	while( i < maxSlots):
		## Rest
		drawRestPoint()
		#Items
		drawItems(i)
		
		center += slot_sizeX
		i += 1
		pass
	setNodes()
	pass

func _on_Button_pressed():
	trashAX.closeWindow()
