extends minigame_objective
var timeCleared

func on_minigame_cleared(_idGame, data) -> void:
	if not _completed and idGame == _idGame and timeCleared != null:
		finish()

func on_minigame_updated(_idGame, data) -> void:
	if not _completed and idGame == _idGame:
		timeCleared = data[0]

func as_text() -> String:
	if not _completed:
		return "Ayuda a Claudia a completar al menos un rompecabezas."
	return "Ayuda a Claudia a completar al menos un rompecabezas. (Completado en %s segundos)" % timeCleared
