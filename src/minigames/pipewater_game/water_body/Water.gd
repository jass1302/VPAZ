extends KinematicBody2D
class_name waterBody

onready var aniT: Tween = get_node("Tween")

func _move(nextStep: Vector2) -> void:
	aniT.interpolate_property(
		self,
		"position",
		global_position,
		nextStep,
		3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	aniT.start()
