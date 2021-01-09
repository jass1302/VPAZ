extends StaticBody2D
onready var anim = $AnimationPlayer
class_name groundProp

func _on_DeathZone_body_entered(body):
	if body is Eagle and body.has_method("lose"):
		body.lose()
