extends CanvasLayer

var hp: int  = 50
onready var anim : AnimationPlayer = get_node("AnimationPlayer")
var _anim: bool = true
func _ready():
	$Label3.text = str(hp)

func _process(delta):
	$Label2.text = str(int($Timer.time_left))

func _on_TextureButton_pressed():
	if hp == 50:
		$Timer.start()
	if hp > 0:
		hp -= 1
		$Label3.text = str(hp)
		anim.play(currAnimation())
	if hp == 0:
		$Timer.paused = true
		queue_free()

func currAnimation() -> String:
	if _anim:
		_anim = not _anim
		return "hit_right"
	else:
		_anim = not _anim
		return "hit_left"
