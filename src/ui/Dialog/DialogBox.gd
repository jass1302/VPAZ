extends Control

var dialog = [
	'Hola, este es un ejemplo de dialogo cargado desde código,',
	'en teroría esto debería poderse cargar desde un archivo',
	'con una estructura JSON, por ejemplo'
]

var dialog_index = 0
var finished = false
func _process(delta):
	$"next-indicator".visible = finished
	if Input.is_action_just_pressed("interact"):
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
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true
