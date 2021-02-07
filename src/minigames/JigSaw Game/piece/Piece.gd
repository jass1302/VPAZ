extends Node2D

var selected : bool = false
var selectable: bool = true
var mouse_over: bool = false

var touched: bool = false

onready var sprite = $face
onready var area = $Area
onready var col = $Area/CollisionShape2D
onready var ani = $AnimationPlayer

var sprtX
var sprtY
var row : int = -1
var column : int = -1

var coord
var _pieces = []
signal _selected(Piece)
signal dropped
signal test


func _ready():
	sprtX = sprite.texture.get_size().x
	sprtY = sprite.texture.get_size().y
	col.shape.extents = Vector2(sprtX*.45,sprtY*.45)
	ani.play("spawn")
	yield(get_tree().create_timer(1),"timeout")
	area.connect("mouse_entered",self,"_mouse_over", [true])
	area.connect("mouse_exited",self,"_mouse_over", [false])
	set_process_unhandled_input(true)

func setCoordenates(r, c) -> void:
	row = r
	column = c

func getCoordenates() -> Vector2: return Vector2(row,column)

func getTextureSize() -> Vector2:
	return Vector2(sprtX,sprtY)

func _unhandled_input(event):
	pass

func _physics_process(delta):
	followMouse(delta)

func followMouse(delta):
	if selected and selectable:
		global_position = get_global_mouse_position()
		
func _mouse_over(over):
	self.mouse_over = over


func _on_Area_input_event(viewport, event, shape_idx):
	for x in _pieces:
		if x.selected:
			touched = true
			break
	
	if event is InputEventScreenTouch and event.pressed and not touched:
		selected = true
		emit_signal("_selected", self)
	
	if event is InputEventScreenTouch and not event.pressed:
		selected = false
		touched = false
		var shortest_dist = 45
		var distance = global_position.distance_to(coord.global_position)
		emit_signal("test")
		if distance < shortest_dist:
			if getCoordenates() == coord.getCoords():
				if selectable:
					selectable = false
					global_position = coord.global_position
					ani.play("selected") 
					$face/SFX.play()
					yield(ani,"animation_finished")
					emit_signal("dropped")
