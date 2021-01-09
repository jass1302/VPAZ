extends Node2D

onready var timer = get_node("Timer")
var obstaclesScn = preload("res://minigames/runnerGame/Obstacles/Obstacles.tscn")

signal obs_created

func _ready():
	pass

func spawnObst() -> void:
	var _obstacle = obstaclesScn.instance()
	add_child(_obstacle)
	emit_signal("obs_created", _obstacle)

func _on_Timer_timeout():
	spawnObst()

func start() -> void:
	timer.start()

func stop() -> void:
	for obs in get_tree().get_nodes_in_group("runnerOb"):
		obs.losed = true
		obs.queue_free()
	timer.stop()
