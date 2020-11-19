extends ActionInterface
class_name DialogueAction

export (String, FILE, "*.json") var dialogue_file_path: String
onready var dialogue_box = $CanvasLayer/DialogBox
signal dialogue_loaded(data)

func action() -> void:
	var dialogue: Dictionary = load_dialogue(dialogue_file_path)
	play_dialogue(dialogue)
	emit_signal("finished")


func load_dialogue(file_path) -> Dictionary:
	
	var file = File.new()
	assert(file.file_exists(file_path))
	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	assert(dialogue.size() > 0)
	return dialogue

func play_dialogue(data):
	dialogue_box.start(data)
	yield(dialogue_box,"dialogue_ended")
