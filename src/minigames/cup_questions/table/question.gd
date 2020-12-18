extends CanvasLayer

onready var question : Label = get_node("Panel/Question/Label")
onready var answer_buttons: Array  = get_tree().get_nodes_in_group("answer")
onready var questionDir : Dictionary = loadQuestionsDB("res://minigames/cup_questions/database/questionsDB.json")
onready var background: TextureRect = get_node("Panel/Question")
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
	background.texture = load(loadBackgrounds(questionInd))
	question.text = questionDir[questionInd].text
	var ind = 1
	for button in answer_buttons:
		var ans = "answer_"+str(ind)
		button.playAnimation()
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
			return questions
	else:
		var x : Dictionary
		return x
func loadBackgrounds(ind : String) -> String:
	match ind:
		"1":
			return "res://minigames/cup_questions/assets/Preguntas-Trivia/background_db/Pregunta1_Sin.png"
		"2":
			return "res://minigames/cup_questions/assets/Preguntas-Trivia/background_db/Pregunta2_Sin4.png"
		"3":
			return "res://minigames/cup_questions/assets/Preguntas-Trivia/background_db/Pregunta3_Sin.png"
		"4":
			return "res://minigames/cup_questions/assets/Preguntas-Trivia/background_db/Pregunta4_Sin.png"
		"5":
			return "res://minigames/cup_questions/assets/Preguntas-Trivia/background_db/Pregunta5_Sin2.png"
		"6":
			return "res://minigames/cup_questions/assets/Preguntas-Trivia/background_db/Pregunta6_Sin3.png"
		"7":
			return "res://minigames/cup_questions/assets/Preguntas-Trivia/background_db/Pregunta7_Sin2.png"
		"8":
			return "res://minigames/cup_questions/assets/Preguntas-Trivia/background_db/Pregunta8_Sin.png"
		"9":
			return "res://minigames/cup_questions/assets/Preguntas-Trivia/background_db/Pregunta9_Sin.png"
		"10":
			return "res://minigames/cup_questions/assets/Preguntas-Trivia/background_db/Pregunta10_Sin2.png"
	return "null"
