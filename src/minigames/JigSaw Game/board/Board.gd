extends Control

export var puzzleName : String
export var columns : int
export var rows: int

onready var panel = $Rompecabezas
onready var piece = preload("res://minigames/JigSaw Game/piece/Piece.tscn")
onready var pre_coor = preload("res://minigames/JigSaw Game/coordenates/Coordenate.tscn")

var pieces  = []
var droppedPieces : int = 0

func _ready():
	randomize()
	generatePieces()
	panel.rect_size.x = pieces[0][0].sprtX * rows
	panel.rect_size.y = pieces[0][0].sprtY * columns
	putCoordenates()

func putCoordenates() -> void:
	var sprtX = pieces[0][0].sprtX
	var sprtY = pieces[0][0].sprtY
	
	var auxX = sprtX / 2
	var auxY = sprtY / 2
	
	for i in range(rows):
		for j in range(columns):
			var coor = pre_coor.instance()
			coor.position.x = auxX
			coor.position.y = auxY
			coor.setCoord(i,j)
			add_child(coor)
			pieces[i][j].coord = coor

			auxX += sprtX
		auxY += sprtY
		auxX = sprtX / 2

func generatePieces() -> void:
	var i = 1
	for row in rows:
		pieces.append([])
		pieces[row] = []
		for col in columns:
			pieces[row].append([])
			var p = piece.instance()
			p.get_node("face").texture = load("res://minigames/JigSaw Game/assets/"+puzzleName+"/"+str(i)+".png")
			i+=1
			p.global_position.x = randi() % 1500
			p.global_position.y = randi() % 1000
			p.setCoordenates(0,0)
			add_child(p)
			p.setCoordenates(row,col)
			p.connect("selected", self, "_setInFront")
			p.connect("dropped",self, "_DoIWin")
			pieces[row][col] = p

func _setInFront(pi):
	move_child(pi, columns * rows)

func _DoIWin():
	droppedPieces += 1
	if droppedPieces == columns * rows:
		print("You Win!")
