extends Control

var fpsCount: int = 0
var started: bool = false

func _ready():
	$AnimationPlayer.play("in")

func _on_TextureButton_pressed():
	$AnimationPlayer.play_backwards("in")
	yield($AnimationPlayer,"animation_finished")
	queue_free()


func _on_FPS_pressed():
	if not started:
		started = true
		$Panel/FPS/fps_timer.start()
	else:
		fpsCount += 1
		if fpsCount == 6:
			for fps in get_tree().get_nodes_in_group("fps_interface"):
				fps.visible = not fps.visible

func _on_fps_timer_timeout():
	started = false
	fpsCount = 0


func _on_Salir_pressed():
	$AnimationPlayer.play("outIn")


func _on_back_pressed():
	$AnimationPlayer.play_backwards("outIn")
	yield($AnimationPlayer,"animation_finished")


func _on_MainMenu_pressed():
	pass # Replace with function body.


func _on_Out_pressed():
	## Save function
	##Llamar función de guardado
	ProfileManager.storeData()
	## /Save function
	$AnimationPlayer.play("fadeOut")
	yield($AnimationPlayer,"animation_finished")
	get_tree().quit()
