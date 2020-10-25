extends KinematicBody2D

## Bandera para saber si el jugador puede tirar objetos
var canDispose : bool = false 
## Se instancia la escena que hace referencia al UI para tirar objetos del inventario
var DisposeScene = preload("res://objects/deposit/DepositUI.tscn").instance()

##
var aux

##
export var trashCanType : int = 1

func _ready():
	match trashCanType:
		1: $Sprite.self_modulate = Color.red
		2: $Sprite.self_modulate = Color.green
		3: $Sprite.self_modulate = Color.blue
		
func _physics_process(delta): ## Este loop se ejecuta una y otra vez
	## De manera que se está revisando constantemente sí la tecla se presiona mientras la bandera es
	## verdadera. La bandera se vuelve veradera si el jugador se posa frente a un bote de basura.
	if Input.is_action_just_pressed("pick") and canDispose or GLOBALS.isActionButton and canDispose:
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
			
			
## Funciones

## Señales
func _on_Area2D_body_entered(body):
	## Revisamos si el cuerpo (body) que entra al Area de detección del bote de basura es
	## un cuerpo de tipo "Jugador"
	if body.is_in_group("Player"):
		print("En área de deposito")
		## En caso de que el cuerpo sea tipo "Player", indicamos con la bandera "canDispose" en verdadero
		## que es posible tirar objetos
		canDispose = true
		GLOBALS.canActionButton = true
		aux = body
func _on_Area2D_body_exited(body):
	## Revisamos si el cuerpo (body) que salió del area de detección del bote de basura era 
	## del tipo "Player"
	if body.is_in_group("Player"):
		## Si era tipo "Player", indicamos con la bandera "canDispose" en falso,
		## que el jugador no puede tirar objetos. Evitando que abra la interfaz para tirarlos en lugares
		## donde no haya botes de basura
		print("Saliste del área de deposito")
		canDispose = false
		GLOBALS.canActionButton = false
