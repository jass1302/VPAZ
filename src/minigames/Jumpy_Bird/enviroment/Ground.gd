extends StaticBody2D
onready var anim = $AnimationPlayer

func _on_DeathZone_body_entered(body):
	if body is Eagle and body.has_method("lose"):
		body.lose()
