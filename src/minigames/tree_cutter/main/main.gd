extends CanvasLayer

onready var main_button: TextureButton = get_node("Start")
onready var backgroundCam: Camera2D = get_node("TextureRect/Camera2D")
onready var Animations: AnimationPlayer = get_node("Animations")
onready var arbol = preload("res://minigames/tree_cutter/Tree/Tree.tscn")
onready var objectiveUI = preload("res://minigames/tree_cutter/ui/Objective.tscn")
onready var SpawnArea: Node2D = get_node("SpawnArea")

func _ready():
	pass

func spawnTrees():
	var ind = 1
	for t in SpawnArea.get_children():
		var newTree = arbol.instance()
		newTree.connect("transition",self,"_transition")
		newTree.position = Vector2(t.position.x,t.position.y)
		print("asdfda"+str(newTree.treeIndx))
		newTree.isCuttable = true
		$YSort.add_child(newTree)
		ind+=1
	
	for tree in $YSort.get_children():
		if tree.tipodearbol[tree.treeIndx] == "Padre":
			tree.isCuttable = false

func _transition() -> void:
	$Animations.play("transition")
	$Animations.play("obj_out")
	yield($Animations,"animation_finished")
	$Animations.play("transition_in")

func _on_Play_button_pressed():
	$Animations.play("obj_in")
	main_button.visible = false
	var showObjective = objectiveUI.instance()
	spawnTrees()
