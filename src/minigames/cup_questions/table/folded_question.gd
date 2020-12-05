extends Node2D
onready var sprites: AnimatedSprite = get_node("AnimatedSprite")


func changeFrame():
	print("ahsf")
	sprites.play("bonus")
