extends Node2D

func _ready():
	for icon in get_tree().get_nodes_in_group("iconProfile"):
		icon.connect("selected",self,"_on_iconProfileSelected")
		print("a")

signal selected(iconName)

func _on_Salir_pressed():
	visible = false

func _on_iconProfileSelected(iconName: String):
	emit_signal("selected",iconName)
	visible = false
