extends Sprite


func _physics_process(delta):

	if ProfileManager.tempCoins == 0:
		visible = false

	else: 
		visible = true
		$Label.text = str("x%s" %ProfileManager.tempCoins)
		if ProfileManager.currentLevel == "lv1" and ProfileManager.tempCoins < 3:
			$reamining.text = "Te faltan %s monedas en este nivel" %(3 - ProfileManager.tempCoins)
		if ProfileManager.currentLevel == "lv2" and ProfileManager.tempCoins < 7:
			$reamining.text = "Te faltan %s monedas en este nivel" %(7 - ProfileManager.tempCoins)
		if ProfileManager.currentLevel == "lv3" and ProfileManager.tempCoins < 10:
			$reamining.text = "Te faltan %s monedas en este nivel" %(10 - ProfileManager.tempCoins)

		if ProfileManager.tempCoins == 3 and ProfileManager.currentLevel == "lv1":
			$reamining.text = "Dirígete a la máquina del tiempo"
		if ProfileManager.tempCoins == 7 and ProfileManager.currentLevel == "lv2":
			$reamining.text = "Dirígete a la máquina del tiempo"
		if ProfileManager.tempCoins == 10 and ProfileManager.currentLevel == "lv3":
			$reamining.text = "Dirígete a la máquina del tiempo"
func wrongAni() -> void:
	$anim.play("faltan")
	yield($anim,"animation_finished")
