extends Node2D

##Card script

signal flipped(Card)
signal clicked(Card)

var is_flipped : bool = false
var card_name : String
var id: int
onready var front = $front
onready var back = $back
onready var click = $clickable_area
onready var anim = $AnimationPlayer
onready var remembertime = $remember_time
onready var clickable_area = $clickable_area

func _ready():
	print(card_name)
	yield(remembertime,"timeout")
	anim.play("cubrir")
	yield(anim,"animation_finished")
	click.connect("clicked", self, "_on_clicked")
func setId(i: String):
	match i:
		"Card_1":
			id = 1
		"Card_1_-":
			id = 1
		"Card_2":
			id = 2
		"Card_2_-":
			id = 2
		"Card_3":
			id = 3
		"Card_3_-":
			id = 3
		"Card_4":
			id = 4
		"Card_4_-":
			id = 4
		"Card_5":
			id = 5
		"Card_5_-":
			id = 5
		"Card_6":
			id = 6
		"Card_6_-":
			id = 6
		"Card_7":
			id = 7
		"Card_7_-":
			id = 7
func setFront(f: String):
	setId(f)
	card_name = f
	front.texture = load("res://minigames/Memory Game/assets/"+card_name+".png")

func globalPos(x, y):
	global_position = Vector2(x, y)
	pass

func flip_card():
	if is_flipped: return
	anim.play("descubrir")
	is_flipped = true
	emit_signal("flipped", self)

func reset():
	if !is_flipped: return
	anim.play("cubrir")
	is_flipped = false
	emit_signal("flipped",self)
	

func _on_clicked() -> void:
	emit_signal("clicked", self)


func _on_Timer_timeout():
	pass # Replace with function body.
