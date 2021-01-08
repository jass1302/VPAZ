extends Node2D

var tipodearbol: Array = ["En V", "Padre", "Podrido", "Torcido"]
var isCuttable: bool = true
var treeIndx: int
var cutMeScene

signal transition
signal treeCutted
signal wrongTree

func _ready():
	randomize()
	treeIndx = randi() % 4
	$Trees.play(tipodearbol[treeIndx])

func cutTree() -> void:
	if isCuttable:
		emit_signal("transition")
		yield(get_tree().create_timer(0.8),"timeout")
		cutMeScene = load("res://minigames/tree_cutter/cutScene/cutTheTree.tscn")
		$AnimatedSprite.visible = true
		var cutGame = cutMeScene.instance()
		cutGame.treeType = tipodearbol[treeIndx]
		cutGame.connect("SceneFinished",self,"_ByeTree")
		add_child(cutGame)
		yield(cutGame,"tree_exited")
		$AnimatedSprite.play("poof")
		yield($AnimatedSprite,"animation_finished")
		#disableTrees()
		queue_free()
	else:
		emit_signal("wrongTree")

func disableTrees() -> void:
	for tree in get_tree().get_nodes_in_group("isCuttable"):
		tree.isCuttable = not tree.isCuttable

func _ByeTree() -> void:
	emit_signal("treeCutted")

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		cutTree()
