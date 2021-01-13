extends Control

func _ready():
	if ProfileManager.tutorialsEnabled:
		$MenuBackground/Tutoriales/Label/CheckBox.pressed = true
		$MenuBackground/Tutoriales/Label/CheckBox2.pressed = false
	else:
		$MenuBackground/Tutoriales/Label/CheckBox.pressed = false
		$MenuBackground/Tutoriales/Label/CheckBox2.pressed = true


func _on_soundLevel_value_changed(value):
	$MenuBackground/Volumen2.text = str(value)


func _on_Back_pressed():
	pass


func _on_CheckBox_pressed():
	$MenuBackground/Tutoriales/Label/CheckBox2.pressed = false


func _on_CheckBox2_pressed():
	$MenuBackground/Tutoriales/Label/CheckBox.pressed = false
