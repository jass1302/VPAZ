extends minigame_objective

var score

func on_minigame_cleared(_idGame, data) -> void:
	if not _completed and idGame == _idGame and score >= 6:
		finish()

func on_minigame_updated(_idGame, data) -> void:
	if not _completed and idGame == _idGame:
		score = data

func as_text() -> String:
	if not _completed:
		return "Completa el juego ¿Dónde está la bolita? y saca una calificación mayor que 6. (Completado)"
	if SCRSYSTEM.highest_ScoreWTB > 0:
		return "Completa el juego ¿Dónde está la bolita? y saca una calificación mayor que 6. Tú última calificación fue %s." % SCRSYSTEM.highest_ScoreWTB
	return "Completa el juego ¿Dónde está la bolita? y saca una calificación mayor que 6."
