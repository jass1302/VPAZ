extends RigidBody2D
class_name Eagle
export var FORCE = -200

const MAX_ROTATION_DEGREES = -20

onready var anim : AnimationPlayer = $AnimationPlayer

var started : bool = false
var alive : bool = true
signal gameStart
signal gameStop

func _ready():
	anim.play("Idle")

func _physics_process(delta):
	if Input.is_action_just_pressed("Click") and alive:
		if !started:
			start()
		flap()
	if rotation_degrees <= MAX_ROTATION_DEGREES:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION_DEGREES
	
	if linear_velocity.y > 0:
		if rotation_degrees <= 15:
			angular_velocity = 3
		else:
			angular_velocity = 0

func start():
	if started: return
	started = true
	gravity_scale = 5.0
	anim.play("flap")
	emit_signal("gameStart")

func flap():
	anim.play("flap")
	linear_velocity.y = FORCE
	angular_velocity = -5

func lose():
	if !alive: return
	alive = false
	anim.stop()
	emit_signal("gameStop")
