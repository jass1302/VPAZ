extends Node2D

onready var timer  = $Timer
var ObstacleScn = preload("res://minigames/Jumpy_Bird/enviroment/Obstacles.tscn")

signal obstacle_created

func _ready():
	randomize()

func _on_Timer_timeout():
	spawn_obst()

func spawn_obst():
	var obstacle = ObstacleScn.instance()
	add_child(obstacle)
	obstacle.position.y = randi()%400 + 200
	emit_signal("obstacle_created",obstacle)

func start():
	timer.start()

func stop():
	timer.stop()
