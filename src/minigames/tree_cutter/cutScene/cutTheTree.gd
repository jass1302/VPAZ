extends CanvasLayer

var hp: int  = 80
onready var anim : AnimationPlayer = get_node("AnimationPlayer")
var _anim: bool = true
var treeType: String
var cutted: bool = false
var coolDown: bool = false
signal SceneFinished

func _ready():
	setTexture()
	$Label3.text = str(hp)
	yield(get_tree().create_timer(0.5),"timeout")
	$Timer.start()

func retry():
	hp = 80
	_anim = true
	cutted = false
	coolDown = false
	$Label3.text = str(hp)
	$Timer.start()

func _process(delta):
	$Label2.text = str(int($Timer.time_left))

func _on_TextureButton_pressed():
	if not cutted and not coolDown:
		$Talador.play("talar")
		cut()
		coolDown = true
		$Cooldown.start()

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
	if hp > 0:
		if hp == 50:
			if treeType == "En V":
				$AnimationPlayer.play("EnV1")
				
			if treeType == "Torcido":
				$AnimationPlayer.play("Torcido")

		if hp == 1:
			if treeType == "En V":
				$AnimationPlayer.play("EnVEnd")
			if treeType == "Torcido":
				$AnimationPlayer.play("Torcido_F")
			if treeType == "Podrido":
				$AnimationPlayer.play("Podrido_F")
		else:
			$AnimationPlayer.play(currAnimation())
		
		hp -= 1
		$LabelAni.play("labelScore")
		$Label3.text = str(hp)

	if hp == 0:
		print("Cutted")
		cutted = true
		$Timer.paused = true
		yield(get_tree().create_timer(1.3),"timeout")
		##Result
		$endGame/Panel/Button.visible = false
		$endGame/Panel/Puntos.visible = true
		$endGame/Panel/Button2.text = "Continuar"
		$endGame/Panel/Results.text = "¡Bien hecho! Completaste el objetivo a tiempo."
		$endGame/Panel/Puntos.text = "Te sobraron %s segundos." % str(int($Timer.time_left))
		$ResultsAni.play("result_scrn")
	print(hp)
func currAnimation() -> String:
	if _anim:
		_anim = not _anim
		match treeType:
			"En V":
				return "EnVHitRight"
			"Torcido":
				return "Torcido_R"
			"Podrido":
				return "Podrido_R"
		return "right"
	else:
		_anim = not _anim
		match treeType:
			"En V":
				return "EnVHitLeft"
			"Torcido":
				return "Torcido_L"
			"Podrido":
				return "Podrido_L"
		return "left"



func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed and not cutted and not coolDown:
		pass

func disableTrees() -> void:
	for tree in get_tree().get_nodes_in_group("isCuttable"):
		tree.isCuttable = not tree.isCuttable


func _on_Button2_pressed():
	if $endGame/Panel/Button2.text == "Continuar":
		$ResultsAni.play("result_scrn_out")
		yield($ResultsAni,"animation_finished")
		disableTrees()
		emit_signal("SceneFinished")
		queue_free()
	if $endGame/Panel/Button2.text == "Reintentar":
		retry()
		$ResultsAni.play("result_scrn_out")
		yield($ResultsAni,"animation_finished")

func _on_Cooldown_timeout():
	coolDown = false


func _on_Timer_timeout():
	$Timer.stop()
	cutted = true
	##Result
	$endGame/Panel/Button.visible = false
	$endGame/Panel/Button2.text = "Reintentar"
	$endGame/Panel/Results.text = "¡Mala suerte! Se te agotó el tiempo."
	$endGame/Panel/Puntos.visible = false
	$ResultsAni.play("result_scrn")
	
