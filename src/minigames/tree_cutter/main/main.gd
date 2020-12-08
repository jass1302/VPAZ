extends Node2D

onready var main_button: Button = get_node("Play_button")
onready var backgroundCam: Camera2D = get_node("TextureRect/Camera2D")
onready var Animations: AnimationPlayer = get_node("Animations")
onready var arbol = preload("res://minigames/tree_cutter/Tree/Tree.tscn")
onready var objectiveUI = preload("res://minigames/tree_cutter/ui/Objective.tscn")
onready var SpawnArea: Node2D = get_node("SpawnArea")

var treeTypes: Dictionary = {
	"Buenos": {
		"desc": "",
		"Árbol padre" : {
			"x" : 1
		},
		"Árbol sano": 12,
		"Árbol frondoso": 3,
		"Árbol de color normal": 52,
	},
	"Malos": {
		
	}
}

func spawnTrees():
	var ind = 1
	for t in SpawnArea.get_children():
		var newTree = arbol.instance()
		newTree.position = Vector2(t.position.x-250,t.position.y-750)
		newTree.tipodearbol = newTree.tipodearbol + str(ind)
		newTree.isCuttable = true
		add_child(newTree)
		ind+=1

func _on_Play_button_pressed():
	main_button.visible = false
	var showObjective = objectiveUI.instance()
	add_child(showObjective)
	yield(showObjective,"tree_exited")
	spawnTrees()
