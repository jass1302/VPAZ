extends CanvasLayer

func _ready():
	$AnimationPlayer.play("Fade_In")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("Press_To_Continue")


func _on_Continue_pressed():
	$AnimationPlayer.play("Fade_Out")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://ui/Interfaces/menu_principal/main_menu.tscn")


func _on_Salir_pressed():
	print("¿Quieres salir?")
	get_tree().quit()


func _on_Config_pressed():
	$settingScreen/AnimationPlayer.play("enterScrn")
	$settingScreen.visible = true
	yield($settingScreen/AnimationPlayer,"animation_finished")
	$settingScreen/ColorRect/Back.disabled = false


func _on_Back_pressed():
	$settingScreen/ColorRect/Back.disabled = true
	$settingScreen/AnimationPlayer.play("outScreen")
	yield($settingScreen/AnimationPlayer,"animation_finished")
	$settingScreen.visible = false
