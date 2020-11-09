extends Node2D

export var SPEED = -800
signal score

func _physics_process(delta):
	position.x += SPEED * delta
	if global_position.x <= -200:
		queue_free()


func _on_Obstacle_body_entered(body):
	if body is Eagle:
		if body.has_method("lose"):
			body.lose()


func _on_EnterArea_body_exited(body):
	if body is Eagle:
		emit_signal("score")
