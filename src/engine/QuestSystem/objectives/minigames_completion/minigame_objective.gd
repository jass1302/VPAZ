extends QuestObjective
class_name minigame_objective

export (
	String,
	"Seleccionar", 
	"RT", ## RainTrash
	"WTB", ## Wheres the Ball
	"Jigsaw", ## Rompecabezas
	"Pipes", ## Juego Tuberias
	"Memorama", ## Memorama del agua
	"TreeGame", ## Árbol que nace torcido...
	"Fishing", # Pesca
	"Waldo", #OntaElAnimal
	"JumpyBird", ## Flying Bird
	"JumpyBird2" ## Runner
	) var idGame


func connect_signals() -> void:
	SCRSYSTEM.connect("completed", self, "on_minigame_cleared")
	SCRSYSTEM.connect("update", self, "on_minigame_updated")

func on_minigame_cleared(_idGame, data) -> void:
	print("DEBES SOBREESCRIBIR LA FUNCIÓN DE COMPLETADO DEL MINIJUEGO")

func on_minigame_updated(_idGame, data) -> void:
	print("DEBES SOBREESCRIBIR LA FUNCIÓN DE ACTUALIZACIÓN DEL MINIJUEGO")
