extends CanvasLayer

onready var objetivo: Label = get_node("Objetivo")

func _ready():
	pass

func _on_TextureButton_pressed():
	queue_free()
