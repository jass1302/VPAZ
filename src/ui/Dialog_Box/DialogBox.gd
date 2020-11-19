extends Control
class_name DialogueBox

signal dialogue_ended

onready var dialogue_player: DialoguePlayer = get_node("DialoguePlayer")

onready var name_label := get_node("Container/Columns/Name") as Label
onready var text_label := get_node("Container/Columns/Text") as Label
onready var button := $TextureButton
onready var portrait := $Portrait as TextureRect
onready var anim := $"next-indicator/AnimationPlayer"
onready var nextSprite = $"next-indicator"
var finish_dialogue: bool = false
var onDialogueAnimation: bool = false

func _ready():
	anim.play("Idle")
func start(dialogue: Dictionary) -> void:
	## Reinitializes the UI and asks the DialoguePlayer to
	## Play the dialogue
	finish_dialogue = false
	dialogue_player.start(dialogue)
	update_content()
	show()


func _on_ButtonNext_pressed():
	dialogue_player.next()
	update_content()

func update_content() -> void:
	var dialogue_player_name = dialogue_player.title
	name_label.text = dialogue_player_name
	dialogue_animation(dialogue_player.text)
	portrait.texture = load(
		NPCDATABASE.get_expression(
			dialogue_player_name, 
			dialogue_player.expression))
	set_portrait_pos(dialogue_player.exp_pos)
	
func set_portrait_pos(pos: String):
	var x
	match pos:
		"right": x = 1430
		"center": x = 800
		"left": x = 75
	portrait.rect_global_position = Vector2(x,280)

	$PortraitTween.interpolate_property(
		portrait,
		"rect_global_position",
		Vector2(x+60,280),
		Vector2(x,280),
		0.25
	)
	$PortraitTween.start()

func dialogue_animation(dialogue : String):
	text_label.text = dialogue
	text_label.percent_visible = 0
	$Tween.interpolate_property(
			text_label, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
	onDialogueAnimation = true
	$Tween.start()

func _on_ButtonFinished_pressed():
	emit_signal("dialogue_ended")
	hide()


func _on_DialoguePlayer_finished():
	finish_dialogue = true


func _on_TextureButton_pressed():
	if not finish_dialogue:
		dialogue_player.next()
		update_content()
	else:
		emit_signal("dialogue_ended")
		hide()


func _on_Tween_tween_completed(object, key):
	nextSprite.visible = true
	button.disabled = false


func _on_Tween_tween_started(object, key):
	nextSprite.visible = false
	button.disabled = true
