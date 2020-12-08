extends StaticBody2D

signal catched(correct)

export var vel: int = 120

var swipe_start_position = Vector2()
var type: int = 1
var selected: bool = false

func _ready():
	connect("swiped",self,"_move")
	set_physics_process(false)

func _physics_process(delta):
	movementLoop()
	touchMovementLoop()

func movementLoop():
	if Input.is_action_just_pressed("mov_right"):
		if position.x == 1560:
			position.x += 0
		else:
			position.x += vel
	if Input.is_action_just_pressed("mov_left"):
		if position.x == 360:
			position.x -= 0
		else:
			position.x -= vel

func touchMovementLoop() -> void:
	if selected:
		if get_global_mouse_position().x >= 360 and get_global_mouse_position().x <= 1560:
			global_position.x = get_global_mouse_position().x

func _move(dir: Vector2) -> void:
	if dir.x < 0: # 1560
		if position.x == 1560:
			position.x += 0
		else:
			position.x += vel
	if dir.x > 0:
		if position.x == 360:
			position.x -= 0
		else:
			position.x -= vel

func _on_Area2D_body_entered(body):
	if body.Trash_Type == type:
		emit_signal("catched",true)
	else:
		emit_signal("catched",false)
	body.queue_free()


func _on_SwipeTimer_timeout():
	emit_signal("swiped_canceled",swipe_start_position)



func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		selected = true
		print("Touched")
	if event is InputEventScreenTouch and not event.pressed:
		selected = false
		print("Untouched")
