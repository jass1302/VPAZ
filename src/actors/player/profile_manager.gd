extends Node2D

export var username: String
export(String,"Seleccionar", "Male", "Female") var gender

func _ready():
	var prueba: String = "Hola, soy usuario"
	print(prueba.find("usuario"))
	
	print(prueba)
func getUsername() -> String:
	return username

func getGender() -> String:
	return gender
