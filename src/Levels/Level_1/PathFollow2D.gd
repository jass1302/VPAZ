extends PathFollow2D

onready var follow = get_node(".")


func _process(delta):
	follow.set_offset(follow.get_offset() + 100 * delta)
