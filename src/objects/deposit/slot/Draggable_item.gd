extends Node2D

## Variable
var obj_type : int = 2
var selected : bool = false
var startNode : bool = false
var Empty : bool = false
var rest_point
var ind : int = 0
var aux_nodes = []
onready var sprite = $spr
## Funciones del nodo

	
func _ready():
	pass

func _physics_process(delta): ##Loop de físicas
	if startNode:
		if selected: ##Si el objeto es seleccionado por un click / touch
			global_position = lerp(
			#Su posición global será calculada de la siguiente manera:
					global_position,
					get_global_mouse_position(),
					25 * delta)
		else:
			global_position = lerp(global_position, rest_point, 10 * delta)

##..

func _input(event):
	if startNode:
		## Revisamos si el evento obtenido proviene del mouse
		if event is InputEventMouseButton:
			## En caso de ser del mouse, revisamos que el botón izquierdo no este
			## siendo presionado
			if event.button_index == BUTTON_LEFT and not event.pressed:
				## De no estar siendo presionado, la bandera selected, pasa a ser
				## falsa, indicando que el objeto no está siendo seleccionado
				selected = false
				##
				var shortest_distance = 75
				##
				for rNode in aux_nodes:
					##
					var distance = global_position.distance_to(
						###
						rNode.global_position)
					##
					if distance < shortest_distance and rNode.get_name() == "disposeObjects":
						setTexture(0)
						rNode.select(ind)
						#rest_point = rNode.global_position
						shortest_distance = distance
				
## Mis Funciones

func setRestNodes(pos):
	aux_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = aux_nodes[pos+1].global_position
	
func setTexture(text):
	if text == 0:
		Empty = true
	else:
		Empty = false
	$spr.texture = load(ItemDb.get_item(text).asset)
	
	 
### Señales
## Señal para saber cuando hay una entrada dentro del Area2D
func _on_Area2D_input_event(viewport, event, shape_idx):
	if startNode:
		if Input.is_action_just_pressed("Click") and not Empty:
			selected = true
