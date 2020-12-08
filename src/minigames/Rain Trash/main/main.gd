extends Node2D

export var vel: int = 108
export var maxTrash: int = 1
export var lifes: int = 5
onready var spawnPoints : Node2D = get_node("World/Spawn_Points")
onready var spawnTimer: Timer = get_node("World/Spawn_Points/Timer")
onready var fallTrash = preload("res://minigames/Rain Trash/Trash/Trash.tscn")
onready var effects: AnimationPlayer = get_node("Effects/AnimationPlayer")
onready var player = get_node("Player")
var score: int = 0
var currBoard : int = 0
var maxBoards: int = 6
var lastTime: int = 0
func _ready():
	player.connect("catched", self, "updateScore")
	get_node("UI/Score/Score").text = str(score)
	randomize()

func updateScore(isCorrect: bool) -> void:
	if isCorrect:
		effects.play("scoreUp")
		score += 100
		_win()
		makeHarder()

	else:
		effects.play("ScoreDown")
		lifes -= 1
		if lifes == 0:
			_lose()
		if score - 100 < 0:
			score = 0
		else:
			score -= 100
	get_node("UI/Score/Score").text = str(score)

func makeHarder() -> void:
	if score % 500 == 0:
		spawnTimer.wait_time = spawnTimer.wait_time - 0.35
		print(spawnTimer.wait_time)

func destroy_remainTrash() -> void:
	var remain_trash = get_tree().get_nodes_in_group("falling_trash")
	for t in remain_trash:
		t.queue_free()

func _win() -> void:
	if score / 100 == 15:
		destroy_remainTrash()
		spawnTimer.stop()
		player.visible = false
		player.set_physics_process(false)
		$UI/Result.text = "GANASTE"
		$UI/Result.visible = true

func _lose() -> void:
	destroy_remainTrash()
	spawnTimer.stop()
	player.visible = false
	player.set_physics_process(false)
	$UI/Result.text = "PERDISTE"
	$UI/Result.visible = true		

func spawnTrash() -> void:
	var pos = randi() % 6
	var type = randi() % 6
	
	if type != currBoard:
		lastTime += 1
	if lastTime == 8:
		lastTime =0
		type = currBoard
	var spawns = spawnPoints.get_children()
	var currTrash = fallTrash.instance()
	currTrash.Trash_Type = type
	currTrash.position = spawns[pos].position
	add_child(currTrash)
	print(lastTime)
	
func _on_Area2D_body_entered(body):
	if body.Trash_Type == player.type:
		updateScore(false)
	body.queue_free()


func _on_Timer_timeout():
	spawnTrash()


func _on_Start_pressed():
	player.type = currBoard
	player.visible = true
	player.set_physics_process(true)
	get_node("World/Spawn_Points/Timer").start()
	get_node("UI/Start").visible = false
