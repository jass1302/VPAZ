extends Node2D

export var puzzleName : String
export var columns : int
export var rows: int

onready var panel: TextureRect = $Rompecabezas
onready var piece = preload("res://minigames/JigSaw Game/piece/Piece.tscn")
onready var pre_coor = preload("res://minigames/JigSaw Game/coordenates/Coordenate.tscn")
onready var monitor = $Monitor

var pieces  = []
var droppedPieces : int = 0
var sizeTo: Vector2
signal boardCompleted

func _ready():
	randomize()
	backgroundSet() 
	generatePieces()
	sizeTo = (Vector2(pieces[0][0].sprtX * rows, pieces[0][0].sprtY * columns))
	panel.rect_scale = sizeTo / panel.texture.get_size()
	panel.rect_position = Vector2((1920 / 2) - (sizeTo.x / 2),
								 (1080 / 2) - (sizeTo.y / 2))
	putCoordenates()

func _physics_process(delta):
	pass

func backgroundSet() -> void:
	var backgroundPath: String
	match puzzleName:
		"board1": backgroundPath = "res://minigames/JigSaw Game/assets/backgrounds/1.png"
		"board2": backgroundPath = "res://minigames/JigSaw Game/assets/backgrounds/2.png"
		"board3": backgroundPath = "res://minigames/JigSaw Game/assets/backgrounds/3.png"
	panel.texture = load(backgroundPath)

func putCoordenates() -> void:
	var sprtX = pieces[0][0].sprtX
	var sprtY = pieces[0][0].sprtY
	
	var auxX = sprtX / 2
	var auxY = sprtY / 2
	
	for i in range(rows):
		for j in range(columns):
			var coor = pre_coor.instance()
			coor.position.x = auxX + panel.rect_position.x
			coor.position.y = auxY + panel.rect_position.y
			coor.setCoord(i,j)
			add_child(coor)
			pieces[i][j].coord = coor
			pieces[i][j]._pieces = get_tree().get_nodes_in_group("Piece_j")

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
			p.get_node("face").texture = load("res://minigames/JigSaw Game/assets/"+puzzleName+"/"+str(i)+".jpg")
			
			if i <= 4:
				p.global_position.x = 200
				p.global_position.y = randi() % 900 + 100
			if i >=  5:
				p.global_position.x = (1920 - 600) + 300
				p.global_position.y = randi() % 900 + 100
			i+=1
			p.setCoordenates(0,0)
			add_child(p)
			p.setCoordenates(row,col)
			p.connect("_selected", self, "_setInFront")
			p.connect("dropped",self, "_DoIWin")
			p.connect("test",self,"test_method")
			pieces[row][col] = p

func _setInFront(pi):
	move_child(pi, columns * rows)
	monitor.text = "Selected"
	print("Monitor")

func _DoIWin():
	droppedPieces += 1
	if droppedPieces == columns * rows:
		emit_signal("boardCompleted")

func test_method():
	monitor.text = "Dropped"
	print("Dropped")
