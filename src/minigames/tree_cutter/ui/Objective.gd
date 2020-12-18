extends CanvasLayer

onready var objetivo: Label = get_node("Objetivo")
var obj: String

func _ready():
	setObjText(obj)

func _on_TextureButton_pressed():
	get_tree().paused = false
	queue_free()

func setObjText(st : String) -> void:
	objetivo.text = st

func showTrashTextures(trashType: int) -> void:
	var item_asset: Array = ItemDb.get_All_Assets_Items(trashType)
	## 400 , 800
	var offSet = 0
	for asset in item_asset:
		var spr = Sprite.new()
		spr.position = Vector2(700 + offSet, 800)
		spr.texture = load(asset)
		add_child(spr)
		offSet += 250
