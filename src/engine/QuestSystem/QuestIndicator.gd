extends Position2D

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	hide()
	animation_player.play("wobble")

func initialize(quest_actions: Array):
	var quest = quest_actions[0].quest
	var name = get_parent().name
	var action_give: GiveQuestAction
	var action_complete: CompleteQuestAction
	for action in quest_actions:
		if action is GiveQuestAction:
			action_give = action
