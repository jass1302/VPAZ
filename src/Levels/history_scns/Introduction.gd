extends CanvasLayer

func _ready():
	GLOBALS.initVolumeAudio()
	$DialogueAction.connect("finished", self, "_onOutCinema")
	$fade.play("fade")
	yield($fade,"animation_finished")
	$DialogueAction/CanvasLayer.layer = 2
	$DialogueAction.action()

func _onOutCinema() -> void:
	$fade.play_backwards("fade")
	yield($fade,"animation_finished")
	get_tree().change_scene("res://Levels/Level_1/Level_1.tscn")
