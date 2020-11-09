extends Node2D

##Card script

signal flipped(Card)
signal clicked(Card)

var is_flipped : bool = false
var card_name : String

onready var front = $front
onready var back = $back
onready var click = $clickable_area
onready var anim = $AnimationPlayer
onready var remembertime = $remember_time
func _ready():
	yield(remembertime,"timeout")
	anim.play("cubrir")
	yield(anim,"animation_finished")
	click.connect("clicked", self, "_on_clicked")

func setFront(f: String):
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
