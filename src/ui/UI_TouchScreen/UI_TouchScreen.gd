extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	$Panel.visible = GLOBALS.canActionButton

func _on_Action_Button_pressed():
	print("pressed")
	GLOBALS.isActionButton = true
	

func _on_Action_Button_released():
	GLOBALS.isActionButton = false
