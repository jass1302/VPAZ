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
		return "Ayuda a Daniel con su memorama"
	return "Ayuda a Daniel con su memorama sobre el aprovechamiento del agua. (Completado en %s segundos)" % timeCleared
