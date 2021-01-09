extends CanvasLayer
onready var spawner = get_node("SpawnObst")
onready var player = get_node("Perrito")
func _ready():
	pass


func _on_Start_pressed():
	$AnimationPlayer.play("backgroundAnimation")
	$Perrito.visible = true
	$Start.visible = false
	spawner.start()


func _on_Salir_pressed():
	pass # Replace with function body.
