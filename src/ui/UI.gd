extends CanvasLayer
class_name UI

onready var tween = $Tween
onready var container = $Control
onready var questUI = $Control/QuestMenu
onready var quest_button = $Control/QuestButton
onready var animation_player = $AnimationPlayer
onready var perfilButton = get_node("Control/PerfilMenu")

func _ready():
	perfilButton.setIcon()
	questUI.connect("updated", self, "_wiggle_element",[quest_button])

	
func _wiggle_element(element) -> void:
	var wiggles = 6
	var offset = Vector2(15, 0)
	var last_position = element.rect_position
	for i in range (wiggles):
		var direction := 1
		if (i % 2) == 0:
			direction = -1
		
		tween.interpolate_property(
			element,
			"rect_position",
			last_position,
			element.rect_position + offset * direction,
			0.05,
			Tween.TRANS_BOUNCE,
			Tween.EASE_IN,
			i * 0.05
		)
		last_position = element.rect_position + offset * direction
		tween.interpolate_property(
			element,
			"rect_position",
			last_position,
			element.rect_position,
			0.05,
			Tween.TRANS_BOUNCE,
			Tween.EASE_IN,
			wiggles * 0.05
		)
		tween.start()
		
func hide_ui() -> void:
	container.visible = false

func show_ui() -> void:
	container.visible = true

func _on_QuestButton_pressed():
	GLOBALS.overPlayer._pause_player()
	animation_player.play(
		"slide_out_quest_journal" if questUI.active else "slide_in_quest_journal"
	)
	questUI.active = not questUI.active
	if not questUI.active:
		quest_button.release_focus()


func _on_PerfilMenu_pressed():
	$Control/ProfileMenu.visible = true
	for b in get_tree().get_nodes_in_group("iconBadge"):
		b.setIcons()
	$Control/ProfileMenu/Back/username/userLabel.text = ProfileManager.getUsername()
	$AnimationPlayer.play("slideInProfile")
	yield($AnimationPlayer,"animation_finished")


func _on_close_pressed():
	$AnimationPlayer.play_backwards("slideInProfile")
	yield($AnimationPlayer,"animation_finished")
	$Control/ProfileMenu.visible = false


func _on_Pause_pressed():
	var pScreen = preload("res://ui/reusableWindows/PauseMenu.tscn")
	add_child(pScreen.instance())
