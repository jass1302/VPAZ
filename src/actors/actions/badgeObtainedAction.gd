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
func action() -> void:
	var _b = badgeScrn.instance()
	_b.set_Badge(iconBadge)
	add_child(_b)
	_b._inScrn()
	yield(_b,"tree_exited")
	emit_signal("finished")
