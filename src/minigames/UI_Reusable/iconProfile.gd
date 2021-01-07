extends TextureButton
export (String,
"Seleccionar",
"Alien",
"Arcoiris",
"Balon",
"Cientifica",
"Cientifico",
"Cohete",
"Corazon",
"Dinosaurio",
"estrella",
"Flor",
"Fogata",
"Gato",
"Hoja",
"HojaVerde",
"Luna",
"Microfono",
"Perrito",
"Pinata",
"Pino",
"Princesa",
"Unicornio"
) var iconProfile
var iconPath: String = "res://assets/icons/avatars/"
onready var button = get_node(".")
signal selected(iconName)
func _ready():
	button.texture_normal = load(iconPath + iconProfile + ".png")


func _on_Salir_pressed():
	visible = false


func _on_iconProfile_pressed():
	emit_signal("selected",iconProfile)
