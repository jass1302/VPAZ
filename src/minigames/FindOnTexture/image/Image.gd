extends Node2D
var spr: String

func setTexture(ind : int) -> void:
	var texture: Texture
	match ind:
		1:
			spr = "res://minigames/FindOnTexture/assets/boards/aguila.png"
			texture = load(spr)
		2:
			spr = "res://minigames/FindOnTexture/assets/boards/berrendo.png"
			texture = load(spr)
		3:
			spr = "res://minigames/FindOnTexture/assets/boards/gavilan.png"
			texture = load(spr)
		4:
			spr = "res://minigames/FindOnTexture/assets/boards/musarana.png"
			texture = load(spr)
		5:
			spr = "res://minigames/FindOnTexture/assets/boards/perrito.png"
			texture = load(spr)
		6:
			spr = "res://minigames/FindOnTexture/assets/boards/pinos.png"
			texture = load(spr)
		7:
			spr = "res://minigames/FindOnTexture/assets/boards/vibora.png"
			texture = load(spr)
	$Sprite.texture = texture
