extends CanvasLayer

var hp: int  = 50
onready var anim : AnimationPlayer = get_node("AnimationPlayer")
var _anim: bool = true
var treeType: String
var cutted: bool = false
func _ready():
	setTexture()
	$Label3.text = str(hp)

func _process(delta):
	$Label2.text = str(int($Timer.time_left))

func _on_TextureButton_pressed():
	pass
func setTexture() -> void:
	match treeType:
		"En V":
			$Trees.texture = load("res://minigames/tree_cutter/assets/Tree/Pino_en_V/Pino_0_en_V.png")
		"Padre": 
			$Trees.texture = load("res://minigames/tree_cutter/assets/Tree/Pino padre/Pino_padre.png")
		"Podrido":
			$Trees.texture = load("res://minigames/tree_cutter/assets/Tree/Pino podridos con plaga/Pino_0_podrido_con_mucha_plaga.png")
		"Torcido":
			$Trees.texture = load(
				"res://minigames/tree_cutter/assets/Tree/Pino torcido/Pino_0_torcido.png"
			)

func cut()-> void:
	if hp == 50:
		$Timer.start()

	if hp > 0:
		if hp == 50:
			if treeType == "En V":
				$AnimationPlayer.play("EnV1")
				
			if treeType == "Torcido":
				print("torcido")
				$AnimationPlayer.play("Torcido")
			
		if hp == 1:
			if treeType == "En V":
				$AnimationPlayer.play("EnVEnd")
			if treeType == "Torcido":
				print("torcido")
				$AnimationPlayer.play("Torcido_F")
		else:
			$AnimationPlayer.play(currAnimation())
		
		hp -= 1
		$LabelAni.play("labelScore")
		$Label3.text = str(hp)

	if hp == 0:
		cutted = true
		$Timer.paused = true
		yield(get_tree().create_timer(1.3),"timeout")
		##Result
		$endGame/Panel/Button.visible = false
		$endGame/Panel/Button2.text = "Continuar"
		$endGame/Panel/Results.text = "¡Bien hecho! Completaste el objetivo a tiempo."
		$endGame/Panel/Puntos.text = "Te sobraron %s segundos." % str(int($Timer.time_left))
		$ResultsAni.play("result_scrn")
		#queue_free()

func currAnimation() -> String:
	if _anim:
		_anim = not _anim
		match treeType:
			"En V":
				return "EnVHitRight"
			"Torcido":
				print("torcido")
				return "Torcido_R"
		return "right"
	else:
		_anim = not _anim
		match treeType:
			"En V":
				return "EnVHitLeft"
			"Torcido":
				print("torcido")
				return "Torcido_L"
		return "left"


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed and not cutted:
		cut()
func disableTrees() -> void:
	for tree in get_tree().get_nodes_in_group("isCuttable"):
		tree.isCuttable = not tree.isCuttable


func _on_Button2_pressed():
	if $endGame/Panel/Button2.text == "Continuar":
		$ResultsAni.play("result_scrn_out")
		yield($ResultsAni,"animation_finished")
		disableTrees()
		queue_free()
