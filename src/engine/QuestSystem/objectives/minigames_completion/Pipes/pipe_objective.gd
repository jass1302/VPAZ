extends minigame_objective

var _cleared: bool = false

func on_minigame_cleared(_idGame, data) -> void:
	if not _completed and idGame == _idGame and not _cleared:
		_cleared = true
		finish()

func as_text() -> String:
	if not _completed:
		return "Ayuda a Elizabeth a arreglar el flujo del agua."
	return "Ayuda a Elizabeth a arreglar el flujo del agua. (Completado)"
