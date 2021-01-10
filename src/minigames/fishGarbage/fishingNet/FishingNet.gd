extends Node2D
var depositInd: int = 0
onready var depositPoints = $depositZones.get_children()
signal collected
var _delta

func _physics_process(delta):
	_delta = delta

func _on_dropZone_body_entered(body):
	if body is water_garbage:
		var currentPoint: Position2D = depositPoints[depositInd]
		body.returningPoint = currentPoint
		body.isDeposited = true
		print("Depositado en: "+currentPoint.get_name())
		depositInd+=1
		get_tree().get_nodes_in_group("fishRod")[0].body_detected = false
		emit_signal("collected")
