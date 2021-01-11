extends Position2D

var row : int
var column : int

func _draw():
	#draw_circle(Vector2.ZERO,10,Color.white)
	pass
func select():
	for child in get_tree().get_nodes_in_group("Coordenate"):
		child.deselect()
	modulate = Color.webmaroon

func deselect():
	modulate = Color.white

func setCoord(r, c) -> void:
	row = r
	column = c

func getCoords() -> Vector2: return Vector2(row,column)
