extends minigame_objective

func on_minigame_cleared(_idGame, data) -> void:
	if not _completed and idGame == _idGame:
		finish()

func as_text() -> String:
	if not _completed:
		return "Ayuda a José bosque a aprovechar su bosque virgen."
	return "Ayuda a José bosque a aprovechar su bosque virgen.. (Completado)"
