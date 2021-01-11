extends Node2D

var selected: bool = false
var flipped: bool = false
var flipInd: int = 1
var pipeType

var waterEntered: bool = false
var waterExited: bool = false

onready var timer: Timer = get_node("letsDrag")
onready var dropZones: Array

var dropZone: Position2D
var dropAux: Position2D

signal dropped
var _dropped: bool = false

func _ready():
	dropZones = get_tree().get_nodes_in_group("dropPipeZone")
	randomize()

func _physics_process(delta):
	followMouse(delta)

func setType() -> void:
	pipeType = randi() % 500
	if pipeType >= 0 and pipeType <= 250:
		$Sprite/Tipo1.visible = true
	if pipeType >= 251 and pipeType <= 500:
		$Sprite/Tipo2.visible = true

func followMouse(delta) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), delta * 25)
	if not selected:
		if not _dropped:
			var short_Dist = 60
			for child in dropZones:
				var dist = global_position.distance_to(child.global_position)
				if dist < short_Dist:
					dropZone = child
					child.remove_from_group("dropPipeZone")
					short_Dist = dist
					if dropAux != dropZone:
						emit_signal("dropped")
						_dropped = true
						_activateDetectors()
		
		global_position = lerp(global_position, dropZone.global_position, delta * 15)

func _flip() -> void:
	match flipInd:
		1:
			rotation_degrees = 90
			if pipeType >= 0 and pipeType <= 250:
				scale.y = 0.3333333333333333 + 0.065
			if pipeType >= 251 and pipeType <= 500:
				pass
			flipInd = 2
		2:
			rotation_degrees = 180
			if pipeType >= 0 and pipeType <= 250:
				scale.y = 0.3333333333333333
			if pipeType >= 251 and pipeType <= 500:
				pass
			flipInd = 3
		3:
			rotation_degrees = 270
			if pipeType >= 0 and pipeType <= 250:
				scale.y = 0.3333333333333333 + 0.065
			if pipeType >= 251 and pipeType <= 500:
				pass
			flipInd = 4
		4: 
			rotation_degrees = 0
			if pipeType >= 0 and pipeType <= 250:
				scale.y = 0.3333333333333333
			if pipeType >= 251 and pipeType <= 500:
				pass
			flipInd = 1

func _on_DraggableArea_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed and not _dropped:
		timer.start()
		print("grabbed")
	if event is InputEventScreenTouch and not event.pressed and not _dropped:
		if not selected:
			_flip()
		timer.stop()
		selected = false
		print("droped")

func _on_letsDrag_timeout():
	selected = true
	timer.stop()

func _activateDetectors() -> void:
	if pipeType >= 0 and pipeType <= 250:
		$Sprite/Tipo1/WaterEntrance/In/one.disabled = false
		$Sprite/Tipo1/WaterEntrance/Out/two.disabled = false
	if pipeType >= 251 and pipeType <= 500:
		$Sprite/Tipo2/WaterEntrance/In/one.disabled = false
		$Sprite/Tipo2/WaterEntrance/Out/two.disabled = false

func _on_In_body_entered(body):
	if body is waterBody:
		if not waterEntered: ## Significa que este acceso funcionó como la entrada del agua
			waterEntered = true
			var routeOut: Vector2
			if pipeType >= 0 and pipeType <= 250: ##Tipo1
				$AnimationPlayer.play("fillWaterVertical_1")
				routeOut = $Sprite/Tipo1/WaterEntrance/Out/two.global_position
			if pipeType >= 251 and pipeType <= 500:
				if $Sprite/Tipo2.rotation_degrees == 0 or $Sprite/Tipo2.rotation_degrees == 0:
					print("A")
					$AnimationPlayer.play("diagonalWater1")
				else:
					print("B")
					$AnimationPlayer.play("diagonalWater2")
				routeOut = $Sprite/Tipo2/WaterEntrance/Out/two.global_position
			routeOut = Vector2(routeOut.x + 20, routeOut.y - 20)
			body._move(routeOut)

func _on_Out_body_entered(body):
	if body is waterBody:
		if not waterEntered: ## Significa que este acceso funcionó como la entrada del agua
			waterEntered = true
			var routeOut: Vector2
			if pipeType >= 0 and pipeType <= 250: ##Tipo1
				$AnimationPlayer.play("fillWaterVertical_1")
				routeOut = $Sprite/Tipo1/WaterEntrance/In/one.global_position
			if pipeType >= 251 and pipeType <= 500:
				if $Sprite/Tipo2.rotation_degrees == 0 or $Sprite/Tipo2.rotation_degrees == 0:
					print("A")
					$AnimationPlayer.play("diagonalWater1")
				else:
					print("B")
					$AnimationPlayer.play("diagonalWater2")
				routeOut = $Sprite/Tipo2/WaterEntrance/In/one.global_position
			routeOut = Vector2(routeOut.x + 20, routeOut.y - 20)
			body._move(routeOut)


func _on_In_body_exited(body):
	if body is waterBody:
		if waterEntered:
			print("Salió de la tuberia")


func _on_Out_body_exited(body):
	if body is waterBody:
		if waterEntered:
			print("Salió de la tuberia")
