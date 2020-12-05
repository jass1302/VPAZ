extends Control

onready var _username: LineEdit = $VBoxContainer/LineEdit
onready var _male: Button = $VBoxContainer/HBoxContainer/Button
onready var _female: Button = $VBoxContainer/HBoxContainer/Button2
onready var portrait: TextureRect = $Portrait/TextureRect
var user : String = ""
var gender : String = ""



func _on_Next_pressed():
	if user or gender != "":
		ProfileManager.username = user
		ProfileManager.gender = gender
		SAVESYS.save_game(name)
		get_tree().change_scene("res://Levels/Level_1.tscn")
	else:
		print("Algun campo falta")


func _on_LineEdit_text_entered(new_text):
	user = new_text
	$Portrait/Label3.text = user


func _on_LineEdit_text_changed(new_text):
	user = new_text
	$Portrait/Label3.text = user

func _on_LineEdit_text_change_rejected():
	user = ""


func _on_Button_pressed():
	gender = "Male"
	_male.flat = true
	_female.flat = false
	portrait.texture = load("res://actors/player/assets/Male/portraits/Nino_Feliz0001.png")

func _on_Button2_pressed():
	gender = "Female"
	_male.flat = false
	_female.flat = true
	portrait.texture = load("res://actors/player/assets/Female/portraits/happy.png")
