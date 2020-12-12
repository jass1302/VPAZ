extends ActionInterface
class_name DialogueAction

export (String, FILE, "*.json") var dialogue_file_path: String
onready var dialogue_box = $CanvasLayer/DialogBox
onready var dialogue_not_found = { "001" : { "name":"ERROR",  "expression": "sad", "exp_pos": "right", "text":"Vaya! Parece que mi archivo de dialogo se ha perdido." },}
signal dialogue_loaded(data)

func action() -> void:
	var dialogue: Dictionary = load_dialogue(dialogue_file_path)
	yield(play_dialogue(dialogue),"completed")
	emit_signal("finished")


func load_dialogue(file_path) -> Dictionary:
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, file.READ)
		var dialogue = parse_json(file.get_as_text())
		if dialogue.size() > 0:
			return dialogue
		else:
			print("Dialogo no mayor a cero")
			return dialogue_not_found
	else:
		print("Archivo no encontrado")
		return dialogue_not_found

func play_dialogue(data):
	dialogue_box.start(data)
	yield(dialogue_box,"dialogue_ended")
