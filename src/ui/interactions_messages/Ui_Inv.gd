extends Node2D

onready var item_1 = $MarginContainer/VBoxContainer/HBoxContainer/item1
onready var item_2 = $MarginContainer/VBoxContainer/HBoxContainer/item2
onready var item_3 = $MarginContainer/VBoxContainer/HBoxContainer/item3
var inv = [-1,-1,-1]

var onScreen : bool = false

func _ready():
	setProperTextures()
		
func setProperTextures() -> void:
	
	var i = 0
	while(i<3):
		if inv[i] > -1:
			match inv[i]:
				0: 
					var aux = load("res://objects/assets/placeholder1.png")
					auxTextures(i,aux)
				1:
					var aux = load("res://objects/assets/placeholder2.png")
					auxTextures(i,aux)
				2:
					var aux = load("res://objects/assets/placeholder3.png")
					auxTextures(i,aux)
		i+=1
func auxTextures(ind,aux) -> void:
	if ind == 0:
		item_1.texture = aux
	if ind == 1:
		item_2.texture = aux
	if ind == 2:
		item_3.texture = aux
