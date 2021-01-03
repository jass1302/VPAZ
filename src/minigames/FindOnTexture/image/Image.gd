extends Node2D
var spr: String

func setTexture(ind : int) -> void:
	var texture: Texture
	match ind:
		1:
			spr = "res://minigames/FindOnTexture/assets/1.png"
			texture = load(spr)
		2:
			spr = "res://minigames/FindOnTexture/assets/2.png"
			texture = load(spr)
		3:
			spr = "res://minigames/FindOnTexture/assets/3.png"
			texture = load(spr)
	$Sprite.texture = texture
