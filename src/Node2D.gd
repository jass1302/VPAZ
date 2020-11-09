extends Control

onready var time = $Timer
onready var rect = $Panel/ColorRect




func _on_Timer_timeout():
	rect.rect_position.y += rect.rect_size.y


func _on_Button_pressed():
	rect.rect_position.x -= rect.rect_size.x


func _on_Button2_pressed():
	rect.rect_position.x += rect.rect_size.x
