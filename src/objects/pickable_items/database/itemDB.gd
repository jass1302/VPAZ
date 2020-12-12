extends Node

const ICON_PATH = "res://objects/assets/"
const TRASH_PATH = "res://objects/assets/trash/"
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
		"Desc": "Se componen naturalmente y tiene la propiedad de poder desintegrarse o degradarse rápidamente, transformándose en otra materia orgánica. Los residuos orgánicos se componen de restos de comida y restos vegetales de origen domiciliario.",
		"asset": "res://objects/assets/trash/Organico/label.png",
		"on_asset": ICON_PATH + "placeholder1_on.png",
		"item": {
			1: {
				"name": "Manzana",
				"asset": TRASH_PATH + "Organico/normal/Manzana.png",
				"bonus_asset":TRASH_PATH + "Organico/bonus/Manzana_dorada.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
			2: {
				"name": "Platano",
				"asset": TRASH_PATH + "Organico/normal/Platano.png",
				"bonus_asset":TRASH_PATH + "Organico/bonus/Platano_dorado.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
			3: {
				"name": "Mango de Cuchillo",
				"asset": TRASH_PATH + "Organico/normal/Mango_de_cuchillo.png",
				"bonus_asset":TRASH_PATH + "Organico/bonus/Mango_de_cuchillo_dorado.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
		}
	},
	2: {
		"name": "Inorgánico",
		"Desc": "<<< Pending description >>",
		"asset": "res://objects/assets/trash/Inorganico/label.png",
		"on_asset": "res://objects/assets/trash/Inorganico/label.png",
		"item": {
			1: {
				"name": "Cubrebocas Azúl",
				"asset": TRASH_PATH + "Inorganico/normal/Cubrebocas_aqua.png",
				"bonus_asset":TRASH_PATH + "Inorganico/bonus/Cubrebocas_aqua_dorado.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
			2: {
				"name": "Cubrebocas Blanco",
				"asset": TRASH_PATH + "Inorganico/normal/Cubrebocas_blanco.png",
				"bonus_asset":TRASH_PATH + "Inorganico/bonus/Cubrebocas_blanco_dorado.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
			3: {
				"name": "Bolsa de frituras",
				"asset": TRASH_PATH + "Inorganico/normal/Papitas.png",
				"bonus_asset":TRASH_PATH + "Inorganico/bonus/Papitas_doradas.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
			4: {
				"name": "Tetrapack",
				"asset": TRASH_PATH + "Inorganico/normal/Tetrapack.png",
				"bonus_asset":TRASH_PATH + "Inorganico/bonus/Tetrapack_dorado.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
			5: {
				"name": "Vaso de unicel",
				"asset": TRASH_PATH + "Inorganico/normal/Vaso_de_unicel.png",
				"bonus_asset":TRASH_PATH + "Inorganico/bonus/Vaso_de_unicel_dorado.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
		}
	},
	3: {
		"name": "Papel",
		"Desc": " <<< Pending description >>",
		"asset": "res://objects/assets/trash/Papel/label.png",
		"on_asset": ICON_PATH + "placeholder3_on.png",
		"item": {
			1: {
				"name": "Caja de cartón",
				"asset": TRASH_PATH + "Papel/normal/Caja_de_carton_hd.png",
				"bonus_asset":TRASH_PATH + "Papel/bonus/Caja_de_carton_hd_dorada.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
			2: {
				"name": "Periodico",
				"asset": TRASH_PATH + "Papel/normal/Periodico.png",
				"bonus_asset":TRASH_PATH + "Papel/bonus/Periodico_dorado.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
		}
	},
	4: {
		"name": "Metal",
		"Desc": " <<< Pending description >>",
		"asset": "res://objects/assets/trash/Metal/label.png",
		"on_asset": ICON_PATH + "placeholder3_on.png",
		"item": {
			1: {
				"name": "Lata de Métal",
				"asset": TRASH_PATH + "Metal/Lata_de_matal.png",
				"bonus_asset":TRASH_PATH + "Metal/Lata_de_matal_dorado.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
		}
	},
	5: {
		"name": "Vidrio",
		"Desc": " <<< Pending description >>",
		"asset": "res://objects/assets/trash/Vidrio/label.png",
		"on_asset": ICON_PATH + "placeholder3_on.png",
		"item": {
			1: {
				"name": "Envase de vidrio",
				"asset": TRASH_PATH + "Vidrio/normal/Envase_de_vidrio.png",
				"bonus_asset":TRASH_PATH + "Vidrio/bonus/Envase_de_vidrio_dorado.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
			2: {
				"name": "Vaso de vidrio",
				"asset": TRASH_PATH + "Vidrio/normal/Vaso_de_vidrio.png",
				"bonus_asset":TRASH_PATH + "Vidrio/bonus/Vaso_de_vidrio_dorado.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
		}
	},
	6: {
		"name": "Plástico",
		"Desc": " <<< Pending description >>",
		"asset": "res://objects/assets/trash/Plastico/label.png",
		"on_asset": ICON_PATH + "placeholder3_on.png",
		"item": {
			1: {
				"name": "Botella",
				"asset": TRASH_PATH + "Plastico/normal/Botella.png",
				"bonus_asset":TRASH_PATH + "Plastico/bonus/Botella_dorada.png",
				"on_asset": ICON_PATH + "placeholder1_on.png",
			},
			2: {
				"name": "Bolsa de plástico",
				"asset": TRASH_PATH + "Plastico/normal/Bolsa_de_camiceta_rosa.png",
				"bonus_asset":TRASH_PATH + "Plastico/bonus/Bolsa_de_camiceta_dorada.png",
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
	randomize()

func get_assetItem(trashType: int):
	var itemList = ITEMS[trashType].item.size()
	var randomItem = randi() % itemList + 1
	return ITEMS[trashType].item[randomItem].asset
	
func get_All_Assets_Items(trashType: int) -> Array:
	var assets : Array = []
	for a in ITEMS[trashType].item:
		assets.append(ITEMS[trashType].item[a].asset)
	return assets
	
func get_BonusassetItem(trashType: int):
	var itemList = ITEMS[trashType].item.size()
	var randomItem = randi() % itemList + 1
	return ITEMS[trashType].item[randomItem].bonus_asset

func get_LabelTrash(trashType: int):
	return ITEMS[trashType].asset

func get_NameTrash(trashType: int):
	return ITEMS[trashType].name
func get_item(item_id):
	if item_id in ITEMS:
		return ITEMS[item_id]
	else:
		return ITEMS[0]
