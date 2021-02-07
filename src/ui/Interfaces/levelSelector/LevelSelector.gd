extends Control

func _ready():
	$AvatarEditable/Label.text = ProfileManager.username
	EnableLevel()
	$AnimationPlayer.play("InButtons")
	yield(get_tree().create_timer(1.3),"timeout")

func EnableLevel() -> void:
	if ProfileManager.clearedLevels[0] == true:
		$Panel/Levels/Level_2.disabled = false
	if ProfileManager.clearedLevels[1] == true:
		$Panel/Levels/Level_3.disabled = false

func _loadingTransition() -> void:
	$AnimationPlayer.play("loading")
	yield(get_tree().create_timer(1.3),"timeout")

func _on_Level_1_pressed():
	$AnimationPlayer.play("loading")
	yield(get_tree().create_timer(1.3),"timeout")
	get_tree().change_scene("res://Levels/Level_1/Level_1.tscn")


func _on_Level_3_pressed():
	$AnimationPlayer.play("loading")
	yield(get_tree().create_timer(1.3),"timeout")
	get_tree().change_scene("res://Levels/Level_3/Level_3.tscn")


func _on_Level_2_pressed():
	$AnimationPlayer.play("loading")
	yield(get_tree().create_timer(1.3),"timeout")
	get_tree().change_scene("res://Levels/Level_2/Level_2.tscn")
