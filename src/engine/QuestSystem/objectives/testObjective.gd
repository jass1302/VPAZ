extends QuestObjective

class_name testObjective

export var itemType : int
export var amount : int

func connect_signals() -> void:
	InvHandler.connect("grabbedItem",self,"_on_item_grabbed")

func _on_item_grabbed(item) -> void:
	print(item)
	if _completed:
		return
	if(itemType == item):
		amount -= 1
		print(amount)
		print("Objetivo actualizado")
		emit_signal("updated",self)
		if amount == 0 and not _completed:
			finish()

func as_text() -> String:
	if not _completed:
		return "Debes recoger " + str(amount) + " de tipo " + str(itemType) + "."
	return  "Debes recoger " + str(amount) + " de tipo " + str(itemType) + "."+" ( Completado )"
