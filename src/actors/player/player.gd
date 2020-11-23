extends KinematicBody2D
class_name Player

# Variables
#*-------------------
var max_speed = 300 # Velocidad máxima de desplazamiento del jugador
var speed = 0 # Velocidad actual de desplazamiento
var acceleration = 600 # Aceleración en la que se llega al max_speed
var movedir   #Dirección de movimiento como entrada del animation player
var moving = false  # Variable booleana para saber si el jugador se mueve o no.
var destination = Vector2() #Lugar al que el jugador se desplazará
var movement = Vector2() # El movimiento xdd
var paused = false
## Variables para manejo de interacciones
var picking : bool = false
onready var inventario = preload("res://ui/read_inventario/Inventario.tscn").instance()

## Animation Selector
onready var _animation = $animation
export(String, "Male", "Female") var character_sprite
var frames: SpriteFrames
#*------------

func _ready():
	loadAnimationFrames()
	_animation.set_sprite_frames(frames)
	_animation.playing = true
	inventario._ready()

#La siguiente función se encarga de obtener el destino
# al que el jugador se moverá luego de un click.
func _unhandled_input(event):
	if not paused:
		if event.is_action_pressed("Click"):
			moving = true
			destination = get_global_mouse_position()
			#print(destination)
#*------------

## La función process es un ciclo que maneja los cambios
## en la parte gráfica del juego.
# warning-ignore:unused_argument
func _process(delta):
	AnimationLoop()
#*------------

#*Esta función funciona parecido a la anterior
#* pero esta maneja las físicas del nodo
func _physics_process(delta):
	MovementLoop(delta)  
	inventaryLoop()

#*------------

func inventaryLoop():
	if Input.is_action_just_pressed("inv"):
		if not inventario.onScrn:
			inventario.setInventario()
			self.add_child(inventario)
			inventario.onScrn = true
			print(InvHandler.getItems())
			print("Total agarrados: ",SCRSYSTEM.getTotalGrabbed())
		else:
			inventario.onScrn = false
			self.remove_child(inventario)		

## ....

##_____
func MovementLoop(delta):
	if moving == false:
		speed = 0
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
	movement = position.direction_to(destination) * speed
	movedir = rad2deg(destination.angle_to_point(position))
	if position.distance_to(destination) > 5:
		movement = move_and_slide(movement)
		#print(movement)
	else:
		moving = false
func loadAnimationFrames() -> void:
	match character_sprite:
		"Male":
			frames = load("res://actors/player/assets/Male/animation.tres")
		"Female":
			frames = load("res://actors/player/assets/Female/animation.tres")
			
func AnimationLoop():
	var animDir = "E"
	var animMode = "Run"
	var animation
	
	#print(movedir)
	if movedir <= 15 and movedir >= -15:
		animDir = "E"
		
		
	elif movedir <= 60 and movedir >= 15:
		animDir = "SE"
	
	
	elif movedir <= 120 and movedir >= 60:
		animDir = "S"
	
	
	elif movedir <= 165 and movedir >= 120:
		animDir = "SO"
		
		
	elif movedir >= -60 and movedir <= -15:
		animDir = "NE"
		
		
	elif movedir >= -120 and movedir <= -60:
		animDir = "N"
	
	elif movedir >= -165 and movedir <= -120:
		animDir = "NO"
	
	elif movedir >= -180 and movedir <= 180:
		animDir = "O"
		
	if moving == true:
		animMode = "Run"
	
	elif moving == false:
		animMode = "Idle"

	animation = animMode+animDir
	_animation.play(animation)
