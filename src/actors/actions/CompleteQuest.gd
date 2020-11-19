extends ActionInterface
class_name CompleteQuestAction

export var quest_reference: PackedScene
var quest: Quest = null

func _ready():
	assert(quest_reference)
	quest = QUESTSYSTEM.getQuestAvaible(quest_reference.instance())
	active = false
	quest.connect("completed", self, "_on_Quest_completed")

func  _on_Quest_completed() -> void:
	active = true

func action() -> void:
	get_tree().paused = false
	if not active:
		emit_signal("finished")
		return
	QUESTSYSTEM.deliver(quest)
	emit_signal("finished")
