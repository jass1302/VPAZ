extends Panel
func _on_Button_pressed():
	for n in get_tree().get_nodes_in_group("UI_P"):
		var pScreen = preload("res://ui/reusableWindows/PauseMenu.tscn")
		n.add_child(pScreen.instance())
