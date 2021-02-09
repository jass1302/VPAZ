extends Node

func find_quest(_quest: Quest) -> Quest:
	for quest in get_children():
		if quest.name == _quest.name:
			return quest
	return null
func findByTitle(title: String) -> Quest:
	for quest in get_children():
		if quest.title == title:
			return quest
	return null
func get_quests() -> Array:
	return get_children()
