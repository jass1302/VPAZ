extends RigidBody2D
class_name perrito

export var UP_IMPULSE: float = -80.0
var canJump: bool = true

func _ready():
	$AnimatedSprite.play("run")

func _physics_process(delta):
	if Input.is_action_just_pressed("Click") and canJump:
		_jump()

func _jump() -> void:
	set_linear_velocity(Vector2(0,0))
	apply_central_impulse(Vector2(0, UP_IMPULSE))
	$AnimatedSprite.stop()
	$AnimatedSprite.play("jump")
	yield($AnimatedSprite,"animation_finished")
	$AnimatedSprite.play("run")


func _on_jumpChecker_body_entered(body):
	if body is groundProp:
		print("CanJump")
		canJump = true


func _on_jumpChecker_body_exited(body):
	if body is groundProp:
		print("CannotJump")
		canJump = false
