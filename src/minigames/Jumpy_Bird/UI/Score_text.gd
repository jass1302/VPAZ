extends Node2D

var score : int = 0
onready var scr_text = $Score_text


func _ready():
	scr_text.text = str(score)

func updateScore():
	score += 1
	scr_text.text = str(score)
