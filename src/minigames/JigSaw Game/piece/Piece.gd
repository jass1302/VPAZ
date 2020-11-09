extends Node2D

var selected : bool = false
var selectable: bool = true
var mouse_over: bool = false

onready var sprite = $face
onready var area = $Area
onready var col = $Area/CollisionShape2D
onready var ani = $AnimationPlayer

var sprtX
var sprtY
var row : int = -1
var column : int = -1

var coord
signal selected(Piece)
signal dropped

func _ready():
	sprtX = sprite.texture.get_size().x
	sprtY = sprite.texture.get_size().y
	col.shape.extents = Vector2(sprtX*.35,sprtY*.35)
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
	if event is InputEventMouseButton and mouse_over:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_tree().set_input_as_handled()
			selected = true
			emit_signal("selected", self)
		else:
			if event.button_index == BUTTON_LEFT and not event.pressed:
				selected = false
				var shortest_dist = 75
				var distance = global_position.distance_to(coord.global_position)
				if distance < shortest_dist:
					if getCoordenates() == coord.getCoords():
						if selectable:
							ani.play("selected")
							yield(ani,"animation_finished")
							selectable = false
							global_position = coord.global_position
							emit_signal("dropped")
						#shortest_dist = distance

func _physics_process(delta):
	followMouse(delta)

func followMouse(delta):
	if selected and selectable:
		global_position.x = get_global_mouse_position().x
		global_position.y = get_global_mouse_position().y
		
func _mouse_over(over):
	self.mouse_over = over
