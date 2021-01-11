extends Control

onready var _username: LineEdit = $Panel/VBoxContainer/LineEdit
onready var _male: Button = $Panel/VBoxContainer/HBoxContainer/Button
onready var _female: Button = $Panel/VBoxContainer/HBoxContainer/Button2
onready var ProfileChooser = get_node("ProfileChooser")

var user : String = ""
var gender : String = ""
var profileIcon: String = ""

func _ready():
	ProfileChooser.connect("selected", self, "_changeIcon")
	#$Instructions/first.action()

func _on_Next_pressed():
	if user!= "" or gender != "" or profileIcon != "":
		ProfileManager.username = user
		ProfileManager.gender = gender
		#SAVESYS.save_game(name)
		$AnimationPlayer.play("fadeOut")
		yield(get_tree().create_timer(1),"timeout")
		get_tree().change_scene("res://Levels/Level_1/Level_1.tscn")
		
	if user == "" or gender == "" or profileIcon == "":
		$AnimationPlayer.play("FaltaAlgo")


func _on_LineEdit_text_entered(new_text):
	user = new_text


func _on_LineEdit_text_changed(new_text):
	user = new_text

func _on_LineEdit_text_change_rejected():
	user = ""


func _on_Button_pressed():
	gender = "Male"
	_male.flat = true
	_female.flat = false
	

func _on_Button2_pressed():
	gender = "Female"
	_male.flat = false
	_female.flat = true

func _changeIcon(iconName: String):
	$Panel/AvatarEditable/Frame/Avatar.texture = load("res://assets/icons/avatars/"+iconName+".png")
	profileIcon = iconName
	ProfileManager.profileIcon = profileIcon

func _on_AvatarEditable_pressed():
	$ProfileChooser.visible = true


func _on_Back_pressed():
	get_tree().change_scene("res://ui/Interfaces/menu_principal/main_menu.tscn")
