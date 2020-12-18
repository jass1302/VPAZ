extends Control


func _ready():
	pass


func _on_TestField_pressed():
	get_tree().change_scene("res://Levels/Level_1.tscn")

func _on_Memorama_pressed():
	get_tree().change_scene("res://minigames/Memory Game/main.tscn")


func _on_Flappy_Bird_pressed():
	get_tree().change_scene("res://minigames/Jumpy_Bird/World.tscn")



func _on_BacktoMainMenu_pressed():
	get_tree().change_scene("res://ui/Interfaces/Debug_Interace/Control.tscn")

func _on_Rompecabezas_pressed():
	get_tree().change_scene("res://minigames/JigSaw Game/main/main.tscn")


func _on_Lluvia_de_basura_pressed():
	get_tree().change_scene("res://minigames/Rain Trash/main/main.tscn")


func _on_Bolita_pressed():
	get_tree().change_scene("res://minigames/cup_questions/main/main.tscn")


func _on_rbol_pressed():
	get_tree().change_scene("res://minigames/tree_cutter/main/main.tscn")
