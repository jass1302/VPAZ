extends Node2D

onready var animation : Tween = get_node("Tween")
onready var label = get_node("Label")
onready var uncover = get_node("Button")
onready var _sprite : Sprite = get_node("Sprite")

onready var question = preload("res://minigames/cup_questions/table/question.tscn")

var cupNumber : int
var questionInd : int
var hasBonus : bool = false

signal finished

func _ready():
	yield(get_tree().create_timer(1), "timeout")
	CoverQuestion()

func animationTween(startingPoint: Vector2, endingPoint: Vector2) -> void:
	animation.interpolate_property(
		self,
		"position",
		startingPoint,
		endingPoint, 0.3,
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	animation.start()

func unCoverQuestion():
	uncover.disabled = true
	animation.interpolate_property(
		self,
		"position",
		Vector2(position.x, position.y),
		Vector2(position.x, position.y - 300), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	
	animation.start()
	yield(animation,"tween_completed")
	var showQuestion = question.instance()
	showQuestion._setQuestion(questionInd)
	showQuestion.hasBonus = hasBonus
	get_tree().get_nodes_in_group("board_cup")[0].add_child(showQuestion)
	#add_child(showQuestion)
	yield(showQuestion,"tree_exited")
	emit_signal("finished")

func CoverQuestion():
	animation.interpolate_property(
		self,
		"position",
		Vector2(position.x, position.y),
		Vector2(position.x, position.y + 300), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	
	animation.start()
	yield(animation,"tween_completed")
	
func setLabel(text : String) -> void:
	label.text = text


func _on_Tween_tween_completed(object, key):
	pass # Replace with function body.


func _on_Button_pressed():
	unCoverQuestion()
	pass
