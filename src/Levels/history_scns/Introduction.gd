extends CanvasLayer

func _ready():
	$DialogueAction.connect("finished", self, "_onOutCinema")
	$fade.play("fade")
	yield($fade,"animation_finished")
	$DialogueAction/CanvasLayer.layer = 2
	$DialogueAction.action()

func _onOutCinema() -> void:
	$fade.play_backwards("fade")
	yield($fade,"animation_finished")
	queue_free()
