extends StaticBody2D

signal swiped(direction)
signal swiped_canceled(start_position)

signal catched(correct)

export (float, 1.0, 1.5) var MAX_DIAGONAL_SLOPE = 1.3
onready var swipe_timer: Timer = get_node("SwipeTimer")

var swipe_start_position = Vector2()
var detecting = false
export var vel: int = 120
var type: int = 1

func _ready():
	connect("swiped",self,"_move")
	set_physics_process(false)
	
func _input(event):
	if not event is InputEventScreenTouch:
		return
	if event.pressed:
		_start_detection(event.position)
	elif not swipe_timer.is_stopped():
		_end_detection(event.position)

func _start_detection(position):
	swipe_start_position = position
	detecting = not detecting
	swipe_timer.start()

func _end_detection(position):
	detecting = not detecting
	swipe_timer.stop()
	var direction = (position - swipe_start_position).normalized()
	if abs(direction.x) + abs(direction.y) > MAX_DIAGONAL_SLOPE:
		return
	
	if abs(direction.x) > abs(direction.y):
		print("Horizontal")
		emit_signal("swiped", Vector2(-sign(direction.x),0.0))
	
	else:
		emit_signal("swiped_canceled",swipe_start_position)

func _physics_process(delta):
	movementLoop()

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
