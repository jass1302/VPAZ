extends TextureButton
func _ready():
	setIcon()
func setIcon() -> void:
	$Frame/Avatar.texture = load("res://assets/icons/avatars/"+ProfileManager.profileIcon+".png")
