extends RigidBody2D

export var Trash_Type: int = 0
onready var sprites: AnimatedSprite = get_node("Sprite")
onready var label: Label = get_node("TemporaryLabel")
func _ready():
	setTexture()
	label.text = str(Trash_Type + 1)

func setTexture() -> void:
	match Trash_Type:
		0:
			sprites.play("red")
		1:
			sprites.play("green")
		2:
			sprites.play("blue")
		3:
			sprites.play("red")
		4:
			sprites.play("green")
		5:
			sprites.play("blue")
