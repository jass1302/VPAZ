extends TextureButton

func _on_Config_pressed():
	var settingScreen = preload("res://ui/reusableWindows/settingScreen.tscn")
	for n in get_tree().get_nodes_in_group("UI_R"):
		n.add_child(settingScreen.instance())
