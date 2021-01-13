extends Control

export(String, "Seleccionar", 
"M1",
"M2",
"M3",
"M4",
"M5",
"M6",
"M7",
"M8",
"M9",
"M10") var tutoName: String
onready var tuto: TextureRect = get_node("Tutorial/tut1")
onready var routeImages: Array
var tutInd: int = 0
var _Minigames: Dictionary = {
	"M1":
		{
			1: "res://assets/tutorials/Minijuego_1/Paso_1_1.png",
			2: "res://assets/tutorials/Minijuego_1/Paso_1_2.png",
			3: "res://assets/tutorials/Minijuego_1/Paso_2.png",
			4: "res://assets/tutorials/Minijuego_1/Paso_3.png",
			5: "res://assets/tutorials/Minijuego_1/Paso_4.png",
			6: "res://assets/tutorials/Minijuego_1/Paso_5.png",
			7: "res://assets/tutorials/Minijuego_1/Paso_6.png",
			8: "res://assets/tutorials/Minijuego_1/Paso_7_1.png",
			9: "res://assets/tutorials/Minijuego_1/Paso_7_2.png",
			10: "res://assets/tutorials/Minijuego_1/Paso_7_3.png",
			11: "res://assets/tutorials/Minijuego_1/Paso_8_centro_1.png",
			12: "res://assets/tutorials/Minijuego_1/Paso_8_centro_2.png",
			13: "res://assets/tutorials/Minijuego_1/Paso_8_derecha.png",
			14: "res://assets/tutorials/Minijuego_1/Paso_8_izquierda.png",
			15: "res://assets/tutorials/Minijuego_1/Paso_9.png"
		},
	"M2": {
		1: "res://assets/tutorials/Minijuego_2/Paso_1_1.png",
		2: "res://assets/tutorials/Minijuego_2/Paso_1_2.png",
		3: "res://assets/tutorials/Minijuego_2/Paso_2.png",
		4: "res://assets/tutorials/Minijuego_2/Paso_3.png",
		5: "res://assets/tutorials/Minijuego_2/Paso_4.png",
		6: "res://assets/tutorials/Minijuego_2/Paso_5.png",
		7: "res://assets/tutorials/Minijuego_2/Paso_6.png",
		8: "res://assets/tutorials/Minijuego_2/Paso_7_1.png",
		9: "res://assets/tutorials/Minijuego_2/Paso_7_2.png"
	},
	"M3": {
		1: "res://assets/tutorials/Minijuego_3/Paso_1_1.png",
		2: "res://assets/tutorials/Minijuego_3/Paso_1_2.png",
		3: "res://assets/tutorials/Minijuego_3/Paso_2.png",
		4: "res://assets/tutorials/Minijuego_3/Paso_2_2.png",
		5: "res://assets/tutorials/Minijuego_3/Paso_3.png",
		6: "res://assets/tutorials/Minijuego_3/Paso_4.png",
		7: "res://assets/tutorials/Minijuego_3/Paso_5_1.png",
		8: "res://assets/tutorials/Minijuego_3/Paso_5_2.png",
		9: "res://assets/tutorials/Minijuego_3/Paso_6.png",
		10: "res://assets/tutorials/Minijuego_3/Paso_7_1.png",
		11: "res://assets/tutorials/Minijuego_3/Paso_7_2.png",
		12: "res://assets/tutorials/Minijuego_3/Paso_8.png"
	},
	"M4": {
		1: ""
	},
	"M5": {
		1: "res://assets/tutorials/Minijuego_5/Paso_1_1.png",
		2: "res://assets/tutorials/Minijuego_5/Paso_1_2.png",
		3: "res://assets/tutorials/Minijuego_5/Paso_2.png",
		4: "res://assets/tutorials/Minijuego_5/Paso_3.png",
		5: "res://assets/tutorials/Minijuego_5/Paso_4.png",
		6: "res://assets/tutorials/Minijuego_5/Paso_5.png"
	},
	"M6": {
		1: "res://assets/tutorials/Minijuego_6/Paso_1_1.png",
		2: "res://assets/tutorials/Minijuego_6/Paso_1_2.png",
		3: "res://assets/tutorials/Minijuego_6/Paso_2.png",
		4: "res://assets/tutorials/Minijuego_6/Paso_3.png",
		5: "res://assets/tutorials/Minijuego_6/Paso_4.png",
		6: "res://assets/tutorials/Minijuego_6/Paso_5.png",
		7: "res://assets/tutorials/Minijuego_6/Paso_6_1.png",
		8: "res://assets/tutorials/Minijuego_6/Paso_6_2.png",
		9: "res://assets/tutorials/Minijuego_6/Paso_8.png"
	},
	"M7": {
		1: ""
		
	},
	"M8": {
		1: "res://assets/tutorials/Minijuego_8/Paso_1_1.png",
		2: "res://assets/tutorials/Minijuego_8/Paso_1_2.png",
		3: "res://assets/tutorials/Minijuego_8/Paso_2.png",
		4: "res://assets/tutorials/Minijuego_8/Paso_3.png",
		5: "res://assets/tutorials/Minijuego_8/Paso_4.png",
		6: "res://assets/tutorials/Minijuego_8/Paso_5.png",
		7: "res://assets/tutorials/Minijuego_8/Paso_6.png",
		8: "res://assets/tutorials/Minijuego_8/Paso_7.png",
		9: "res://assets/tutorials/Minijuego_8/Paso_8_1.png",
		10: "res://assets/tutorials/Minijuego_8/Paso_8_2.png",
		11: "res://assets/tutorials/Minijuego_8/Paso_8_3.png",
		12: "res://assets/tutorials/Minijuego_8/Paso_8_4.png"
	},
	"M9": {
		1: "res://assets/tutorials/Minijuego_9/Paso_1.png",
		2: "res://assets/tutorials/Minijuego_9/Paso_2.png",
		3: "res://assets/tutorials/Minijuego_9/Paso_3_1.png",
		4: "res://assets/tutorials/Minijuego_9/Paso_3_2.png",
		5: "res://assets/tutorials/Minijuego_9/Paso_4_1.png",
		6: "res://assets/tutorials/Minijuego_9/Paso_4_2.png",
		7: "res://assets/tutorials/Minijuego_9/Paso_5_1.png",
		8: "res://assets/tutorials/Minijuego_9/Paso_5_2.png",
		9: "res://assets/tutorials/Minijuego_9/Paso_6_1.png",
		10: "res://assets/tutorials/Minijuego_9/Paso_6_2.png"
	},
	"M10": {
		1: ""
	}
}

func _ready():
	for r in _Minigames[tutoName]:
		routeImages.append(_Minigames[tutoName][r])
	tuto.texture = load(routeImages[tutInd])
	


func _on_after_pressed():
	$AnimationPlayer.play("_next")
	yield(get_tree().create_timer(0.3),"timeout")

	if tutInd == routeImages.size() - 1:
		queue_free()
	else:
		tutInd += 1
		if tutInd > 0:
			$Tutorial/back.visible = true
		tuto.texture = load(routeImages[tutInd])
		$VBoxContainer/Label2.text = "Paso %s" %str(tutInd + 1)


func _on_back_pressed():
	$AnimationPlayer.play("_next")
	yield(get_tree().create_timer(0.3),"timeout")
	tutInd -= 1
	if tutInd == 0:
		$Tutorial/back.visible = false
	tuto.texture = load(routeImages[tutInd])
	$VBoxContainer/Label2.text = "Paso %s" %str(tutInd + 1)


func _on_close_pressed():
	$AnimationPlayer.play("_next")
	yield(get_tree().create_timer(0.3),"timeout")
	queue_free()
