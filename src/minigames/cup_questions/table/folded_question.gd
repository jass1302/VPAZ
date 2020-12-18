extends Node2D
onready var sprites: AnimatedSprite = get_node("AnimatedSprite")


func changeFrame():
	sprites.play("bonus")
