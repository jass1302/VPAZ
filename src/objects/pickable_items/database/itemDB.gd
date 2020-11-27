extends Node

const ICON_PATH = "res://objects/assets/"
## Clasificación de color residuos



const ITEMS = {
	0: {
		"name": "vacio",
		"Desc": " <<< Pending description >>",
		"asset": ICON_PATH + "placeholder_empty.png",
		"on_asset": ICON_PATH + "placeholder_empty.png"
	},
	1: {
		"name": "Orgánico",
		"Desc": " <<< Pending description >>",
		"asset": ICON_PATH + "placeholder1.png",
		"on_asset": ICON_PATH + "placeholder1_on.png",
		"item": {
			"Manzana": {
				"Desc": " <<< Pending description >>",
				"asset": ICON_PATH + "placeholder1.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
		}
	},
	2: {
		"name": "Inorgánico",
		"Desc": " <<< Pending description >>",
		"asset": ICON_PATH + "placeholder2.png",
		"on_asset": ICON_PATH + "placeholder2_on.png",
		"item": {
			"Item-inorganico": {
				"Desc": " <<< Pending description >>",
				"asset": ICON_PATH + "placeholder1.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
		}
		
	},
	3: {
		"name": "Papel",
		"Desc": " <<< Pending description >>",
		"asset": ICON_PATH + "placeholder3.png",
		"on_asset": ICON_PATH + "placeholder3_on.png",
		"item": {
			"Revista rota": {
				"Desc": " <<< Pending description >>",
				"asset": ICON_PATH + "placeholder1.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
		}
	},
	4: {
		"name": "Metal",
		"Desc": " <<< Pending description >>",
		"asset": ICON_PATH + "placeholder3.png",
		"on_asset": ICON_PATH + "placeholder3_on.png",
		"item": {
			"Lata de refresco vacía": {
				"Desc": " <<< Pending description >>",
				"asset": ICON_PATH + "placeholder1.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
		}
	},
	5: {
		"name": "Vidrio",
		"Desc": " <<< Pending description >>",
		"asset": ICON_PATH + "placeholder3.png",
		"on_asset": ICON_PATH + "placeholder3_on.png",
		"item": {
			"Botella de vidrio": {
				"Desc": " <<< Pending description >>",
				"asset": ICON_PATH + "placeholder1.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
		}
	},
	6: {
		"name": "Plástico",
		"Desc": " <<< Pending description >>",
		"asset": ICON_PATH + "placeholder3.png",
		"on_asset": ICON_PATH + "placeholder3_on.png",
		"item": {
			"Bolsa de plástico": {
				"Desc": " <<< Pending description >>",
				"asset": ICON_PATH + "placeholder1.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
		}
	},
	"trashcan": {
		"name": "trashcan",
		"Desc": " <<< Pending description >>",
		"asset": ICON_PATH + "trashcan.png",
		"on_asset": ICON_PATH + "trashcan_on.png",
		"tipo": {
			"Orgánico": { ## Orgánico: Verde RGB(94,188,84)
				"asset": ICON_PATH + "trashCanOrganic.tres"
			},
			
			"Inorgánico": { ## Inorgánico: Gris RGB(174,175,176)
				"asset": ICON_PATH + "trashCanInorganic.tres"
			},
			
			"Papel": { ## Papel: Amarillo RGB(243,204,101)
				"asset": ICON_PATH + "trashCanPaper.tres"
			},
			
			"Vidrio": { ## Metal: Azul RGB(25,155,216)
				"asset": ICON_PATH + "trashCanGlass.tres"
			},
			
			"Metal": { ## Vidrio: Azul cielo RGB(114,201,189)
				"asset": ICON_PATH + "trashCanMetal.tres"
			},
			
			"Plástico": { ## Plástico: Azul marino RGB(20,63,114)
				"asset": ICON_PATH + "trashCanPlastic.tres"
			}
		}
	}
}
func _ready():
	print(get_item("trashcan").tipo["Plástico"])
func get_item(item_id):
	if item_id in ITEMS:
		return ITEMS[item_id]
	else:
		return ITEMS[0]
