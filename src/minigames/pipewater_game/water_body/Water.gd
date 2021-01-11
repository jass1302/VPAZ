extends KinematicBody2D
class_name waterBody

var inPipe: bool = false
onready var spillTimer: Timer = get_node("spilledWater")
onready var aniT: Tween = get_node("Tween")
func _on_spilledWater_timeout():
	if not inPipe:
		print("Perdiste x.x")
		spillTimer.stop()
	else:
		print("KeepGoing")

func _move(nextStep: Vector2) -> void:
	aniT.interpolate_property(
		self,
		"position",
		global_position,
		nextStep,
		3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	aniT.start()
