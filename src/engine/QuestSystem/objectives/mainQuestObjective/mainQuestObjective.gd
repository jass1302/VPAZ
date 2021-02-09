extends QuestObjective

export (
	String,
	"Seleccionar", 
	"Lv1",
	"Lv2",
	"Lv3"
	) var idQuest
var totalQuests: int = 0
var questsCompleted: int = 0

func _ready():
	if idQuest == "Lv1":
		totalQuests = 3
	if idQuest == "Lv2":
		totalQuests = 4
	if idQuest == "Lv3":
		totalQuests = 3

func connect_signals() -> void:
	SCRSYSTEM.connect("mainCompleted", self, "on_MainQuest_cleared")
	SCRSYSTEM.connect("mainUpdated", self, "on_MainQuest_updated")

func on_MainQuest_cleared(levelId: String) -> void:
	print("Señal recibida: "+levelId)
	if not _completed and questsCompleted < totalQuests and idQuest == levelId:
		finish()

func on_MainQuest_updated(levelId: String) -> void:
	print("Señal recibida up: "+levelId)
	if not _completed and questsCompleted < totalQuests and idQuest == levelId:
		questsCompleted+=1
		print("Misiones completadas: "+ str(questsCompleted))
		emit_signal("updated",self)

func as_text() -> String:
	if not _completed:
		return "Has completado "+str(questsCompleted)+" misiones de %s en este nivel." %totalQuests
	return "Completaste todas las misiones, ve a la máquina del tiempo."
