extends ActionInterface
class_name badge_action

export (String,
"Seleccionar",
"Mini1",
"Mini2",
"Mini3",
"Mini4",
"Mini5",
"Mini6",
"Mini7",
"Mini8",
"Mini9",
"Mini10",
"badge_0",
"badge_1",
"badge_2",
"badge_3"
) var iconBadge
onready var badgeScrn = preload("res://ui/Interfaces/profileMenu/BadgeObtained.tscn")
func getInd() -> int:
	var ind
	match iconBadge:
		"Mini1": ind = 0
		"Mini2": ind = 1
		"Mini3": ind = 2
		"Mini4": ind = 3
		"Mini5": ind = 4
		"Mini6": ind = 5
		"Mini7": ind = 6
		"Mini8": ind = 7
		"Mini9": ind = 8
		"Mini10": ind = 9
	return ind
func action() -> void:
	if ProfileManager.obtainedBadges[getInd()]:
		var _b = badgeScrn.instance()
		_b.set_Badge(iconBadge)
		add_child(_b)
		_b._inScrn()
		yield(_b,"tree_exited")
		emit_signal("finished")
