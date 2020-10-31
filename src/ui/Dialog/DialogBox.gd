extends Control

var dialog = []

var dialog_index = 0
var finished = false
func _process(delta):
	$"next-indicator".visible = finished
	if Input.is_action_just_pressed("ui_select"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		queue_free()
		get_tree().paused = false
	dialog_index += 1

func setDialog(text : Array) -> void:
	dialog = text
	print(dialog)

func _on_Tween_tween_completed(object, key):
	finished = true
