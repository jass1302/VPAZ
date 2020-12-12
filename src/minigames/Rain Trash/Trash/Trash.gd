extends RigidBody2D
class_name falling_trash
export var Trash_Type: int = 0
onready var sprite: Sprite = get_node("Sprite")
onready var label: Label = get_node("TemporaryLabel")

func _ready():
	setTexture()
	label.text = str(Trash_Type + 1)

func setTexture() -> void:
	sprite.texture = load(ItemDb.get_assetItem(Trash_Type + 1))
