extends Node2D

export var SPEED = -800
var aux: Array = [false, false]
signal score

func _physics_process(delta):
	position.x += SPEED * delta
	if $Obstacle.position.x <= -200:
		$Obstacle.queue_free()
		aux[0] = true
	if $Obstacle2.position.x <= 200:
		$Obstacle2.queue_free()
		aux[1] = true
	
	if aux[0] == true and aux[1] == true:
		queue_free()

func _on_Obstacle_body_entered(body):
	pass # Replace with function body.


func _on_ScoreArea_body_entered(body):
	pass # Replace with function body.
