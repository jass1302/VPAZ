extends CanvasLayer

onready var ObstSpawner = $ObstSpawner
onready var Eagle = $Eagle
onready var Score = $Score
onready var startMessage = $"Press Tap !"
onready var ground  = $Ground

func _ready():
	Eagle.connect("gameStart",self, "startgame")
	Eagle.connect("gameStop",self,"stopgame")
	ObstSpawner.connect("obstacle_created", self, "_on_obstacle_created")
	
func startgame():
	startMessage.visible = false
	Score.visible = true 
	ObstSpawner.start()

func stopgame():
	ObstSpawner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("jump_obstacle","set_physics_process",false)

func updateScore():
	Score.updateScore()

func _on_obstacle_created(obs):
	obs.connect("score",self,"updateScore")
