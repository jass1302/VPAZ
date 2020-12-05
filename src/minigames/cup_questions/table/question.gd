extends CanvasLayer

onready var question : RichTextLabel= get_node("Panel/Question/Label")
onready var answer_buttons: Array  = get_tree().get_nodes_in_group("answer")
onready var questionDir : Dictionary = loadQuestionsDB("res://minigames/cup_questions/database/questionsDB.json")
var questionInd: String = "8"
var points : int = 2
var hasBonus: bool = false

func _ready():
	
	populateTemplate()
	for button in answer_buttons:
		button.connect("answered", self, "_answered")

func _setQuestion(ind : int):
	questionInd = str(ind)

func _answered(_isCorrect) -> void:
	print(questionInd)
	var upScore = get_tree().get_nodes_in_group("cupmain")[0]
	upScore.questionPool[int(questionInd)] = int(questionInd)
	if _isCorrect:
		if hasBonus:
			points = points * 1.5
		upScore.wasCorrect = _isCorrect
		upScore.correctAnswers += points
	if not _isCorrect:
		upScore.wasCorrect = _isCorrect
	queue_free()
	
func populateTemplate() -> void:
	question.bbcode_text = questionDir[questionInd].text
	var ind = 1
	for button in answer_buttons:
		var ans = "answer_"+str(ind)
		button.text = questionDir[questionInd][ans].text
		button.isCorrect = questionDir[questionInd][ans].isCorrect
		ind+=1

func loadQuestionsDB(file_path: String) -> Dictionary:
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, file.READ)
		var questions = parse_json(file.get_as_text())
		if questions.size() > 0:
			return questions
		else:
			print("Dialogo no mayor a cero")
			return questions
	else:
		print("Archivo no encontrado")
		var x : Dictionary
		return x
