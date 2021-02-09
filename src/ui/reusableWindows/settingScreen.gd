extends Control

func _ready():
	$AnimationPlayer.play("enterScrn")
	$ColorRect/MenuBackground/BGM/bgmVolume.value = ProfileManager.BGMVolume
	$ColorRect/MenuBackground/SFX/SFXValue.value = ProfileManager.SFXVolume
	if ProfileManager.tutorialsEnabled:
		$ColorRect/MenuBackground/Tutoriales/Label/CheckBox.pressed = true
		$ColorRect/MenuBackground/Tutoriales/Label/CheckBox2.pressed = false
	else:
		$ColorRect/MenuBackground/Tutoriales/Label/CheckBox.pressed = false
		$ColorRect/MenuBackground/Tutoriales/Label/CheckBox2.pressed = true


func _on_soundLevel_value_changed(value):
	$ColorRect/MenuBackground/Volumen2.text = str(value)
	ProfileManager.BGMVolume = value
	print(ProfileManager.BGMVolume)
	ProfileManager.SFXVolume = value


func _on_Back_pressed():
	pass


func _on_CheckBox_pressed():
	ProfileManager.tutorialsEnabled = true
	$ColorRect/MenuBackground/Tutoriales/Label/CheckBox2.pressed = false


func _on_CheckBox2_pressed():
	ProfileManager.tutorialsEnabled = false
	$ColorRect/MenuBackground/Tutoriales/Label/CheckBox.pressed = false


func _on_bgmVolume_value_changed(value):
	for bgm in get_tree().get_nodes_in_group("BGM"):
		bgm.volume_db = value
	ProfileManager.BGMVolume = value
	ProfileManager.storeData()

func _on_SFXValue_value_changed(value):
	for sfx in get_tree().get_nodes_in_group("SFX"):
		sfx.volume_db = value
	ProfileManager.SFXVolume = value
	ProfileManager.storeData()


func _on_Close_pressed():
	$AnimationPlayer.play_backwards("enterScrn")
	yield($AnimationPlayer,"animation_finished")
	queue_free()

func _on_Creditos_pressed():
	$ColorRect/creditScreen.visible = true
