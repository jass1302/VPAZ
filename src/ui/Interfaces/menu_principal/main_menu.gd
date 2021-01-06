extends Control

onready var loadGameMenu  = $PopupMenu
onready var loadGameButton = $"Game/Cargar juego"
onready var Save_1 : Button = $Game/VBoxContainer/Save_1
onready var Save_2 : Button = $Game/VBoxContainer/Save_2
onready var Save_3 : Button = $Game/VBoxContainer/Save_3

var save_files : Array = []

func _ready():
	save_files = get_filelist(SAVESYS.saveDir)
	if not save_files.empty():
		loadGameButton.disabled = false
		for file in save_files:
			print(file)

func get_filelist(scan_dir : String) -> Array:
	var my_files : Array = []
	var dir := Directory.new()
	if dir.open(scan_dir) != OK:
		printerr("Warning: could not open directory: ", scan_dir)
		return []

	if dir.list_dir_begin(true, true) != OK:
		printerr("Warning: could not list contents of: ", scan_dir)
		return []

	var file_name := dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			my_files += get_filelist(dir.get_current_dir() + "/" + file_name)
		else:
			my_files.append(dir.get_current_dir() + "/" + file_name)

		file_name = dir.get_next()

	return my_files


func _on_Nuevo_juego_pressed():
	get_tree().change_scene("res://ui/Interfaces/crear_perfil/perfil.tscn")


func _on_Cargar_juego_pressed():
	loadGameMenu.show()


func _on_Save_1_pressed():
	pass # Replace with function body.


func _on_Save_2_pressed():
	pass # Replace with function body.


func _on_Save_3_pressed():
	pass # Replace with function body.


func _on_Back_pressed():
	get_tree().change_scene("res://ui/Interfaces/title_screen/tittle_scrn.tscn")
