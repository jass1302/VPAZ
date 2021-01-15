extends CanvasLayer
func _inScrn() -> void:
	$AnimationPlayer.play("animationIntro")
	yield($AnimationPlayer,"animation_finished")

func set_Badge(badge: String)->void:
	$Panel/rewards/MedallaNivel/iconBadge.iconBadge = badge
	$Panel/rewards/MedallaNivel/iconBadge.setIcons()
	ProfileManager.tempCoins += 1

func _on_TextureButton_pressed():
	$AnimationPlayer.play_backwards("animationIntro")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
