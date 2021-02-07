extends minigame_objective

var maxFases: int = 6
var fasesCompletadas: int = 0

func on_minigame_cleared(_idGame, data) -> void:
	if not _completed and idGame == _idGame and fasesCompletadas == maxFases:
		finish()

func on_minigame_updated(_idGame, data) -> void:
	if not _completed and idGame == _idGame:
		fasesCompletadas += 1
		if fasesCompletadas != data[0]:
			print("Algo anda mal: Rain Trash")
		print("UpdateMe")
		emit_signal("updated",self)
	
func as_text() -> String:
	if not _completed:
		return "Completa todas las fases de la lluvia de basura: "+str(fasesCompletadas)+" de "+str(maxFases)
	return "Completa todas las fases de la lluvia de basura: "+str(fasesCompletadas)+" de "+str(maxFases) +" (Completado)"
