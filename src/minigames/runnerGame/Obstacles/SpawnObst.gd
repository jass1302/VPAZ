extends Node2D

onready var timer = get_node("Timer")
var obstaclesScn = preload("res://minigames/runnerGame/Obstacles/Obstacles.tscn")

signal obs_created

func _ready():
	randomize()

func spawnObst() -> void:
	var _obstacle = obstaclesScn.instance()
	#_obstacle.position.y = 500
	add_child(_obstacle)
	emit_signal("obs_created", _obstacle)

func _on_Timer_timeout():
	spawnObst()

func start() -> void:
	print("gobrrm")
	timer.start()

func stop() -> void:
	timer.stop()
