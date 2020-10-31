extends ActionInterface
class_name GiveQuestAction

export var quest_ref: PackedScene
var quest: Quest = null

func _ready():
	assert(quest_ref)
	quest = QUESTSYSTEM.getQuestAvaible(quest_ref.instance())
	quest.connect("started", self, "_on_Quest_started")

func _on_Quest_started():
	active = true

func action() -> void:
	get_tree().paused = false
	if not active:
		emit_signal("finished")
		return
	var quest: Quest = quest_ref.instance()
	if not QUESTSYSTEM.is_available(quest):
		return
	QUESTSYSTEM.start(quest)
	emit_signal("finished")
