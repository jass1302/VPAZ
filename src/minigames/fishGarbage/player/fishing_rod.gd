extends Node2D

onready var Ball = get_node("Ball")
onready var Hook = get_node("Hook")
var started: bool = false
var touched: bool = false
var body_detected: bool = false
var _body = null

func _physics_process(delta):
	followMouse(delta)
	hookBody(delta)

func _input(event):
	if Input.is_action_just_pressed("Click"):  touched = true
	if Input.is_action_just_released("Click"): touched = false

func followMouse(delta) -> void:
	if started:
		if touched:
			if get_global_mouse_position().x > 50 and get_global_mouse_position().x < 1860:
				Ball.global_position.x = lerp(Ball.global_position.x, get_global_mouse_position().x, 25 * delta)
				Hook.global_position.x = lerp(Hook.global_position.x, get_global_mouse_position().x, 15 * delta)
			if get_global_mouse_position().y > Ball.global_position.y+100 and get_global_mouse_position().y < 1020:
				Hook.global_position.y = lerp(Hook.global_position.y, get_global_mouse_position().y, 25 * delta)

func hookBody(delta) -> void:
	if started:
		if body_detected and _body != null and not _body.isDeposited:
			_body.global_position = lerp(_body.global_position, $Hook/HookPoint.global_position, 25 * delta)
		if touched == false and _body != null:
			_body.grabbed = false
			_body = null
			body_detected = false

func _on_PickArea_body_entered(body):
	if body is water_garbage and not body_detected:
		body_detected = true
		_body = body
		_body.grabbed = true
		print("Detected")
