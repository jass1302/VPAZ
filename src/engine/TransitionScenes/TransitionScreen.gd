extends CanvasLayer

signal transitioned

func transition() -> void:
	$AnimationPlayer.play("fade_to_black")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		emit_signal("transitioned")
		$AnimationPlayer.play("fade_to_normal")
		
	if anim_name == "fade_to_normal":
		print("Finish")
		pass
