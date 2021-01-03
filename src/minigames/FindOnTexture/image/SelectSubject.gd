extends Node2D

export var cols: int = 0
export var rows: int = 0

export var trueX: int = 0
export var trueY: int = 0
onready var buttonGrid = get_node("ButtonGrid")

signal foundIt(isCorrect)

func generateButtonGrid() -> void:
	var frameButton = load("res://minigames/FindOnTexture/image/frameButton/frameButton.tscn")
	var buttonSize = Vector2(
		1920 /  cols,
		1080 / rows
	)
	var currPosition = Vector2.ZERO
	
	for x in range(rows):
		for y in range(cols):
			print("fila: "+str(x) +", columna: "+str(y))
			var _frameButton = frameButton.instance()
			_frameButton.connect("buttonPressed", self, "_isCorrect")
			if x == trueX and y == trueY:
				_frameButton.isHere = true
			_frameButton.rect_size = buttonSize
			_frameButton.rect_position = currPosition
			$ButtonGrid.add_child(_frameButton)
			currPosition.x += buttonSize.x
		currPosition.y += buttonSize.y
		currPosition.x = 0

func setImage(text: String) -> void:
	$Sprite.texture = load(text)

func _isCorrect(isCorrect: bool) -> void:
	if isCorrect:
		emit_signal("foundIt", true)
	else:
		emit_signal("foundIt", false)
