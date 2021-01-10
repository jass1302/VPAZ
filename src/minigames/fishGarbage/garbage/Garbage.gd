extends KinematicBody2D

class_name water_garbage
var returningPoint: Position2D
var originalPoint: Position2D
var isDeposited: bool = false
var grabbed: bool = false
var _isGolden

func _ready():
	randomize()
	_isGolden = _setTexture()

func _physics_process(delta):
	if not isDeposited:
		returnToPoint(delta)
	else:
		global_position = lerp(global_position, returningPoint.global_position, 1 * delta)

func _setTexture() -> bool:
	var texture: Texture
	var isGolden: bool = false
	var ind = randi() % 8 + 1
	var aux = randi() % 2
	if aux == 1: isGolden = true
	match ind:
		1:
			if isGolden: texture = load("res://minigames/fishGarbage/assets/golden/Bolsa_de_camiceta_dorada.png")
			else: texture = load("res://minigames/fishGarbage/assets/default/Bolsa_de_camiceta_rosa.png")
		2:
			if isGolden: texture = load("res://minigames/fishGarbage/assets/golden/Botella_dorada.png")
			else: texture = load("res://minigames/fishGarbage/assets/default/Botella.png")
		3:
			if isGolden: texture = load("res://minigames/fishGarbage/assets/golden/Cubrebocas_blanco_dorado.png")
			else: texture = load("res://minigames/fishGarbage/assets/default/Cubrebocas_aqua.png")
		4:
			if isGolden: texture = load("res://minigames/fishGarbage/assets/golden/Cubrebocas_blanco_dorado.png")
			else: texture = load("res://minigames/fishGarbage/assets/default/Cubrebocas_blanco.png")
		5:
			if isGolden: texture = load("res://minigames/fishGarbage/assets/golden/Lata_aerosol_dorada.png")
			else: texture = load("res://minigames/fishGarbage/assets/default/Lata_aerosol.png")
		6:
			if isGolden: texture = load("res://minigames/fishGarbage/assets/golden/Lata_de_matal_dorado.png")
			else: texture = load("res://minigames/fishGarbage/assets/default/Lata_de_matal.png")
		7:
			if isGolden: texture = load("res://minigames/fishGarbage/assets/golden/Llanta_hd_dorada.png")
			else: texture = load("res://minigames/fishGarbage/assets/default/Llanta_hd.png")
		8: 
			if isGolden: texture = load("res://minigames/fishGarbage/assets/golden/Popote_dorado.png")
			else: texture = load("res://minigames/fishGarbage/assets/default/popote.png")
		9:
			if isGolden: texture = load("res://minigames/fishGarbage/assets/golden/Zapatos_dorado.png")
			else: texture = load("res://minigames/fishGarbage/assets/default/Zapatos.png")
	$Sprite.texture = texture
	return isGolden


func returnToPoint(delta) -> void:
	if not grabbed:
		global_position = lerp(global_position, returningPoint.global_position,1*delta)
