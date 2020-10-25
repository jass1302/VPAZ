extends Panel

func _ready():
	pass
	
func updateMessage(isFull : bool) -> void:
	if isFull:
		$HBoxContainer/Label.text = "Inventario lleno"
