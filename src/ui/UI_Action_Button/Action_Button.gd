extends TextureButton

func _ready():
	visible = false
func _process(delta):
	visible = GLOBALS.canActionButton

func _on_Action_Button_pressed():
	GLOBALS.isActionButton = true
