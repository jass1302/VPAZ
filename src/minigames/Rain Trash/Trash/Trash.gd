extends RigidBody2D
class_name falling_trash
export var Trash_Type: int = 0
onready var sprite: Sprite = get_node("Sprite")
onready var label: Label = get_node("TemporaryLabel")
var _currBoard: int
var is_Golden: bool = false

func _ready():
	randomize()
	setTexture()
	label.text = str(Trash_Type + 1)
	$AnimationPlayer.play("rotate_fall")

func setTexture() -> void:
	var goldenRand = randf()
	if goldenRand > 0.30 and _currBoard == Trash_Type:
		is_Golden = true
		sprite.texture = load(ItemDb.get_BonusassetItem(Trash_Type + 1))
	else:
		sprite.texture = load(ItemDb.get_assetItem(Trash_Type + 1))
