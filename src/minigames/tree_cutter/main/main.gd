extends CanvasLayer

onready var main_button: TextureButton = get_node("Start")
onready var Animations: AnimationPlayer = get_node("Animations")
onready var arbol = preload("res://minigames/tree_cutter/Tree/Tree.tscn")
onready var objectiveUI = preload("res://minigames/tree_cutter/ui/Objective.tscn")
onready var SpawnArea: Node2D = get_node("SpawnArea")

var treesOnScrn: Array = []
var objectivePath: Array = []
var objectiveInd: int = 0

var lifes: int = 3

## Tutorial
onready var tutUI = preload("res://ui/Interfaces/tutorialScreen/tutorialUI.tscn")

func _ready():
	if ProfileManager.tutorialsEnabled:
		var _tutUI = tutUI.instance()
		_tutUI.tutoName = "M6"
		add_child(_tutUI)
		yield(_tutUI,"tree_exited")
	randomize()

func updateObjectivePanel() -> void:
	$Objective/HBoxContainer/Label2.text = "Árbol "+objectivePath[objectiveInd]
	
func updateLifes() -> void:
	$VidasRestantes/HBoxContainer/amount.text = str(lifes)
	if lifes == 0:
		_lose()

func _lose() -> void:
	$endGame/Panel/Button.visible = true
	$endGame/Panel/Button2.visible = true
	$endGame/Panel/Button.text = "Salir"
	$endGame/Panel/Button2.text = "Reintentar"
	$endGame/Panel/Results.text = "¡Qué mal! Agotaste tus intentos."
	$AnimationPlayer.play("result_scrn")

func spawnTrees():
	for t in SpawnArea.get_children():
		var newTree = arbol.instance()
		newTree.connect("transition",self,"_transition")
		newTree.connect("wrongTree", self,"wrongAni")
		newTree.connect("treeCutted", self, "nextObj")
		newTree.position = Vector2(t.position.x,t.position.y)
		newTree.isCuttable = true
		$YSort.add_child(newTree)
	
	for tree in get_tree().get_nodes_in_group("arbolin"):
		if tree.tipodearbol[tree.treeIndx] == "Padre":
			tree.isCuttable = false
		else:
			treesOnScrn.append(tree.tipodearbol[tree.treeIndx])
	
	var aux = randi() % treesOnScrn.size()
	objectivePath.append(treesOnScrn[aux])
	
	aux = randi() % treesOnScrn.size()
	objectivePath.append(treesOnScrn[aux])

	aux = randi() % treesOnScrn.size()
	objectivePath.append(treesOnScrn[aux])
	for tree in get_tree().get_nodes_in_group("arbolin"):
		if tree.tipodearbol[tree.treeIndx] != objectivePath[objectiveInd]:
			tree.isCuttable = false

	updateObjectivePanel()

func nextObj() -> void:
	objectiveInd+=1
	if objectiveInd < objectivePath.size():
		updateObjectivePanel()
		$Animations.play("transition_in")
		yield($Animations,"animation_finished")
		$Animations.play("obj_in")
		for tree in $YSort.get_children():
			if tree.tipodearbol[tree.treeIndx] != objectivePath[objectiveInd]:
				tree.isCuttable = false
			else:
				tree.isCuttable = true
	else:
		$Animations.play("transition_in")
		yield($Animations,"animation_finished")
		$endGame/Panel/Button.visible = false
		$endGame/Panel/Button2.visible = true
		$endGame/Panel/Button2.text = "Finalizar"
		$endGame/Panel/Results.text = "¡ Juego completado !"
		$AnimationPlayer.play("result_scrn")

func wrongAni() -> void:
	$Animations.play("wrongAni")
	lifes -=1
	updateLifes()
	
func retry() -> void:
	$Animations.play("obj_out")
	yield($Animations,"animation_finished")
	$Animations.play("transition")
	yield($Animations,"animation_finished")
	for tr in get_tree().get_nodes_in_group("arbolin"):
		tr.queue_free()
	treesOnScrn.clear()
	objectivePath.clear()
	objectiveInd = 0
	lifes = 3
	updateLifes()
	spawnTrees()
	$Animations.play("transition_in")
	yield($Animations,"animation_finished")
	$Animations.play("obj_in")
	yield($Animations,"animation_finished")

func _transition() -> void:
	$Animations.play("obj_out")
	yield($Animations,"animation_finished")
	$Animations.play("transition")
	yield($Animations,"animation_finished")

func _on_Play_button_pressed():
	$Animations.play("transition")
	yield($Animations,"animation_finished")
	updateLifes()
	$VidasRestantes.visible = true
	main_button.visible = false
	var showObjective = objectiveUI.instance()
	spawnTrees()
	$Animations.play("transition_in")
	yield($Animations,"animation_finished")
	$Animations.play("obj_in")
	

func quit() -> void:
	$AnimationPlayer.play("result_scrn_out")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("fadeOut")
	yield($AnimationPlayer,"animation_finished")
	queue_free()

func _on_Button2_pressed():
	if $endGame/Panel/Button2.text == "Reintentar":
		$AnimationPlayer.play("result_scrn_out")
		yield($AnimationPlayer,"animation_finished")
		retry()
	if $endGame/Panel/Button2.text == "Finalizar":
		quit()


func _on_Button_pressed():
	quit()
