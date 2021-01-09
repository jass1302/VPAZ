extends TextureRect

var shader_material
var screen_size = Vector2(1920,1080)
var selected: bool = false

func _ready():
	shader_material = material;
	shader_material.set_shader_param("aspect_ratios", screen_size.y / screen_size.x);
	
func _process(delta):
	movementLoop()

func movementLoop() -> void:
	if selected:
		print("kkh")
		var norm_mouse = get_viewport().get_mouse_position() / screen_size;
		norm_mouse.y = 1.0 - norm_mouse.y;
		shader_material.set_shader_param("mouse_pos", norm_mouse);
		update();


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		print("aa")
		selected = true
	if event is InputEventScreenTouch and not event.pressed:
		selected = false
