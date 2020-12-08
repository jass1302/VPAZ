extends Node2D

var tipodearbol: String = "PLACEHOLDER"
var isCuttable: bool
onready var cutMeScene: PackedScene = preload("res://minigames/tree_cutter/cutScene/cutTheTree.tscn")

func _on_TextureButton_pressed():
	if isCuttable:
		$TextureButton.visible = false
		$AnimatedSprite.visible = true
		var cutGame = cutMeScene.instance()
		add_child(cutGame)
		yield(cutGame,"tree_exited")
		$AnimatedSprite.play("poof")
		yield($AnimatedSprite,"animation_finished")
		queue_free()
	else:
		$AnimationPlayer.play("wrongTree")
