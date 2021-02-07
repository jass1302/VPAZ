extends CanvasLayer

onready var noDataPath = get_node("NoDatFound")

func _ready():
	$NoDatFound/DialogueAction/CanvasLayer.layer = 2
	#executeNoDataPath()
	setButtonBehaviour()

func executeNoDataPath() -> void:
	for act in noDataPath.get_children():
		act.action()

func _on_Back_pressed():
	get_tree().change_scene("res://ui/Interfaces/title_screen/tittle_scrn.tscn")

func setButtonBehaviour():
	var dir  = Directory.new()
	if not dir.file_exists("user://_saves//save.tres"):
		$Button.text = "Juego nuevo"
		$Label.text = "No se han encontrado datos guardados en el teléfono, presiona el siguiente botón para iniciar un nuevo juego."
	else:
		$Label.text = "Se han encontrado datos de guardado, presiona el siguiente botón para continuar."
		$Button.text = "Continuar"


func _on_Button_pressed():
	if $Button.text == "Juego nuevo":
		var dir = Directory.new()
		dir.make_dir_recursive("user://_saves/")
		get_tree().change_scene("res://ui/Interfaces/crear_perfil/perfil.tscn")

	if $Button.text == "Continuar":
		ProfileManager.loadData()
		get_tree().change_scene("res://ui/Interfaces/levelSelector/LevelSelector.tscn")
