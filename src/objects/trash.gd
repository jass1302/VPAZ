extends Area2D

export var tipo = 0
var canPicked = false
onready var sprite = $Sprite


func _ready():
	sprite.texture = load(ItemDb.get_item(tipo).asset)

func _physics_process(delta):
	toStorage()

func toStorage():
	if canPicked and Input.is_action_just_pressed("interact") or canPicked and GLOBALS.isActionButton:
			if InvHandler.grabItem(tipo):
				queue_free()	 


func _on_trash_body_entered(body):
	sprite.texture = load(ItemDb.get_item(tipo).on_asset)
	GLOBALS.canActionButton = true
	canPicked = true

func _on_trash_body_exited(body):
	GLOBALS.canActionButton = false
	canPicked = false
	sprite.texture = load(ItemDb.get_item(tipo).asset)
