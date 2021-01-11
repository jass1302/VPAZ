extends Panel

export var col: int = 7
export var rows: int = 7
var currentPos: Vector2 = Vector2.ZERO
onready var _frame: Texture = preload("res://minigames/FindOnTexture/buttonframe.png")

func _ready():
	generateBoard()

func generateBoard() -> void:
	var aux: Vector2 = Vector2(rect_size.x/7,rect_size.y/7)
	var aX = aux.x / 2
	var aY = aux.y / 2
	
	var aux2 = aux
	var aX2 = 0
	var aY2 = 0
	
	for r in range(rows):
		for c in range(col):
			currentPos = Vector2(aX,aY)
			var frame: TextureRect = TextureRect.new()
			#frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
			frame.expand = true
			frame.texture = _frame
			frame.rect_position = Vector2(aX2, aY2)
			frame.rect_size = aux
			add_child(frame)
			var Spawn: Position2D = Position2D.new()
			Spawn.position = currentPos
			Spawn.add_to_group("dropPipeZone")
			add_child(Spawn)
			aX += aux.x
			aX2 += aux.x
		aY += aux.y
		aY2+= aux.y
		aX = aux.x / 2
		aX2 = 0
