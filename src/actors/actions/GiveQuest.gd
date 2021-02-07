extends ActionInterface
class_name GiveQuestAction

export var quest_ref: PackedScene
export var prev_quest: PackedScene

var quest: Quest = null
var p_quest: Quest = null

func _ready():
	quest = QUESTSYSTEM.getQuestAvaible(quest_ref.instance())
	quest.connect("started", self, "_on_Quest_started")

func _on_Quest_started():
	active = true

func action() -> void:
	if QUESTSYSTEM.is_completed(prev_quest.instance()):
		if not active:
			emit_signal("finished")
			return
		var quest: Quest = quest_ref.instance()
		if not QUESTSYSTEM.is_available(quest):
			print("Not Available")
			return
		yield(get_tree().create_timer(0.25),"timeout")
		QUESTSYSTEM.start(quest)
		emit_signal("finished")
	else:
		emit_signal("finished")
