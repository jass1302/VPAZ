extends Node

const ASSET_PATH = "res://actors/npc/Class/Assets/"

func _ready():
	pass

const NPCS = {
	"ERROR": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Carlos/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Carlos/portraits/Default.png",
			"happy": ASSET_PATH + "Carlos/portraits/Happy.png",
			"sad": ASSET_PATH + "Carlos/portraits/Sad.png",
			"talking": ASSET_PATH + "Carlos/portraits/Talking.png",
			"worried": ASSET_PATH + "Carlos/portraits/Worried.png",
		}
	},
	"Male": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Carlos/animation.tres",
		"expressions": {
			"default": "res://actors/player/assets/Male/portraits/default.png",
			"happy": "res://actors/player/assets/Male/portraits/happy.png",
			"sad": "res://actors/player/assets/Male/portraits/sad.png",
			"talking": "res://actors/player/assets/Male/portraits/talking.png",
			"worried": "res://actors/player/assets/Male/portraits/worried.png",
		}
	},
	"Female": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Carlos/animation.tres",
		"expressions": {
			"default": "res://actors/player/assets/Female/portraits/default.png",
			"happy": "res://actors/player/assets/Female/portraits/happy.png",
			"sad": "res://actors/player/assets/Female/portraits/sad.png",
			"talking": "res://actors/player/assets/Female/portraits/talking.png",
			"worried": "res://actors/player/assets/Female/portraits/worried.png",
		}
	},
	"Carlos": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Carlos/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Carlos/portraits/Default.png",
			"happy": ASSET_PATH + "Carlos/portraits/Happy.png",
			"sad": ASSET_PATH + "Carlos/portraits/Sad.png",
			"talking": ASSET_PATH + "Carlos/portraits/Talking.png",
			"worried": ASSET_PATH + "Carlos/portraits/Worried.png",
		}
	},
	"Cartero": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Cartero/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Cartero/portraits/Default.png",
			"happy": ASSET_PATH + "Cartero/portraits/Happy.png",
			"sad": ASSET_PATH + "Cartero/portraits/Sad.png",
			"talking": ASSET_PATH + "Cartero/portraits/Talking.png",
			"worried": ASSET_PATH + "Cartero/portraits/Worried.png",
		}
	},
	"Cientifica": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Cientifica/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Cientifica/portraits/Default.png",
			"happy": ASSET_PATH + "Cientifica/portraits/Happy.png",
			"sad": ASSET_PATH + "Cientifica/portraits/Sad.png",
			"talking": ASSET_PATH + "Cientifica/portraits/Talking.png",
			"worried": ASSET_PATH + "Cientifica/portraits/Worried.png",
		}
	},
	"Cientifico": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Cientifico/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Cientifico/portraits/Default.png",
			"happy": ASSET_PATH + "Cientifico/portraits/Happy.png",
			"sad": ASSET_PATH + "Cientifico/portraits/Sad.png",
			"talking": ASSET_PATH + "Cientifico/portraits/Talking.png",
			"worried": ASSET_PATH + "Cientifico/portraits/Worried.png",
		}
	},
	"Claudia": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Claudia/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Claudia/portraits/Default.png",
			"happy": ASSET_PATH + "Claudia/portraits/Happy.png",
			"sad": ASSET_PATH + "Claudia/portraits/Sad.png",
			"talking": ASSET_PATH + "Claudia/portraits/Talking.png",
			"worried": ASSET_PATH + "Claudia/portraits/Worried.png",
		}
	},
	"Daniel": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Daniel/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Daniel/portraits/Default.png",
			"happy": ASSET_PATH + "Daniel/portraits/Happy.png",
			"sad": ASSET_PATH + "Daniel/portraits/Sad.png",
			"talking": ASSET_PATH + "Daniel/portraits/Talking.png",
			"worried": ASSET_PATH + "Daniel/portraits/Worried.png",
		}
	},
	"Diana": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Diana/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Diana/portraits/Default.png",
			"happy": ASSET_PATH + "Diana/portraits/Happy.png",
			"sad": ASSET_PATH + "Diana/portraits/Sad.png",
			"talking": ASSET_PATH + "Diana/portraits/Talking.png",
			"worried": ASSET_PATH + "Diana/portraits/Worried.png",
		}
	},
	"Elizabeth": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Elizabeth/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Elizabeth/portraits/Default.png",
			"happy": ASSET_PATH + "Elizabeth/portraits/Happy.png",
			"sad": ASSET_PATH + "Elizabeth/portraits/Sad.png",
			"talking": ASSET_PATH + "Elizabeth/portraits/Talking.png",
			"worried": ASSET_PATH + "Elizabeth/portraits/Worried.png",
		}
	},
	"Horm": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Horm/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Horm/portraits/Default.png",
			"happy": ASSET_PATH + "Horm/portraits/Happy.png",
			"sad": ASSET_PATH + "Horm/portraits/Sad.png",
			"talking": ASSET_PATH + "Horm/portraits/Talking.png",
			"worried": ASSET_PATH + "Horm/portraits/Worried.png",
		}
	},
	"José Luis": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Jose Luis/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Jose Luis/portraits/default.png",
			"happy": ASSET_PATH + "Jose Luis/portraits/happy.png",
			"sad": ASSET_PATH + "Jose Luis/portraits/sad.png",
			"talking": ASSET_PATH + "Jose Luis/portraits/talking.png",
			"worried": ASSET_PATH + "Jose Luis/portraits/worried.png",
		}
	},
	"Juan Carlos": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Juan Carlos/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Juan Carlos/portraits/Default.png",
			"happy": ASSET_PATH + "Juan Carlos/portraits/Happy.png",
			"sad": ASSET_PATH + "Juan Carlos/portraits/Sad.png",
			"talking": ASSET_PATH + "Juan Carlos/portraits/Talking.png",
			"worried": ASSET_PATH + "Juan Carlos/portraits/Worried.png",
		}
	},
	"Minero": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Minero/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Minero/portraits/Default.png",
			"happy": ASSET_PATH + "Minero/portraits/Happy.png",
			"sad": ASSET_PATH + "Minero/portraits/Sad.png",
			"talking": ASSET_PATH + "Minero/portraits/Talking.png",
			"worried": ASSET_PATH + "Minero/portraits/Worried.png",
		}
	},
	"NPC-Niña": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "NPC-Niña/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "NPC-Niña/portraits/Default.png",
			"happy": ASSET_PATH + "NPC-Niña/portraits/Happy.png",
			"sad": ASSET_PATH + "NPC-Niña/portraits/Sad.png",
			"talking": ASSET_PATH + "NPC-Niña/portraits/Talking.png",
			"worried": ASSET_PATH + "NPC-Niña/portraits/Worried.png",
		}
	},
	"PoliciaF": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "PoliciaF/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "PoliciaF/portraits/Default.png",
			"happy": ASSET_PATH + "PoliciaF/portraits/Happy.png",
			"sad": ASSET_PATH + "PoliciaF/portraits/Sad.png",
			"talking": ASSET_PATH + "PoliciaF/portraits/Talking.png",
			"worried": ASSET_PATH + "PoliciaF/portraits/Worried.png",
		}
	},
	"PoliciaM": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "PoliciaM/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "PoliciaM/portraits/Default.png",
			"happy": ASSET_PATH + "PoliciaM/portraits/Happy.png",
			"sad": ASSET_PATH + "PoliciaM/portraits/Sad.png",
			"talking": ASSET_PATH + "PoliciaM/portraits/Talking.png",
			"worried": ASSET_PATH + "PoliciaM/portraits/Worried.png",
		}
	},
	"Presidente": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Presidente/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Presidente/portraits/Default.png",
			"happy": ASSET_PATH + "Presidente/portraits/Happy.png",
			"sad": ASSET_PATH + "Presidente/portraits/Sad.png",
			"talking": ASSET_PATH + "Presidente/portraits/Talking.png",
			"worried": ASSET_PATH + "Presidente/portraits/Worried.png",
		}
	},
	"Señor corbata": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Señor corbata/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Señor corbata/portraits/Default.png",
			"happy": ASSET_PATH + "Señor corbata/portraits/Happy.png",
			"sad": ASSET_PATH + "Señor corbata/portraits/Sad.png",
			"talking": ASSET_PATH + "Señor corbata/portraits/Talking.png",
			"worried": ASSET_PATH + "Señor corbata/portraits/Worried.png",
		}
	},
	"Señora": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Señora/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Señora/portraits/Default.png",
			"happy": ASSET_PATH + "Señora/portraits/Happy.png",
			"sad": ASSET_PATH + "Señora/portraits/Sad.png",
			"talking": ASSET_PATH + "Señora/portraits/Talking.png",
			"worried": ASSET_PATH + "Señora/portraits/Worried.png",
		}
	},
	"Señorita": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "Señorita/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "Señorita/portraits/Default.png",
			"happy": ASSET_PATH + "Señorita/portraits/Happy.png",
			"sad": ASSET_PATH + "Señorita/portraits/Sad.png",
			"talking": ASSET_PATH + "Señorita/portraits/Talking.png",
			"worried": ASSET_PATH + "Señorita/portraits/Worried.png",
		}
	},
	"TecConafor": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "TecConafor/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "TecConafor/portraits/Default.png",
			"happy": ASSET_PATH + "TecConafor/portraits/Happy.png",
			"sad": ASSET_PATH + "TecConafor/portraits/Sad.png",
			"talking": ASSET_PATH + "TecConafor/portraits/Talking.png",
			"worried": ASSET_PATH + "TecConafor/portraits/Worried.png",
		}
	},
	"TecJiapaz": {
		"desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in est nec arcu condimentum sagittis.",
		"asset_folder": ASSET_PATH + "TecJiapaz/animation.tres",
		"expressions": {
			"default": ASSET_PATH + "TecJiapaz/portraits/Default.png",
			"happy": ASSET_PATH + "TecJiapaz/portraits/Happy.png",
			"sad": ASSET_PATH + "TecJiapaz/portraits/Sad.png",
			"talking": ASSET_PATH + "TecJiapaz/portraits/Talking.png",
			"worried": ASSET_PATH + "TecJiapaz/portraits/Worried.png",
		}
	},

}
func get_npc(name):
	if name in NPCS:
		return NPCS[name]
	else:
		return NPCS["ERROR"]
		
func get_expression(name, portrait):
	return get_npc(name).expressions[portrait]
