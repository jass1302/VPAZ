extends Node

const ICON_PATH = "res://objects/assets/"
const ITEMS = {
	0: {
		"name": "vacio",
		"asset": ICON_PATH + "placeholder_empty.png",
		"on_asset": ICON_PATH + "placeholder_empty.png"
	},
	1: {
		"name": "uno",
		"asset": ICON_PATH + "placeholder1.png",
		"on_asset": ICON_PATH + "placeholder1_on.png"
	},
	2: {
		"name": "dos",
		"asset": ICON_PATH + "placeholder2.png",
		"on_asset": ICON_PATH + "placeholder2_on.png"
		
	},
	3: {
		"name": "tres",
		"asset": ICON_PATH + "placeholder3.png",
		"on_asset": ICON_PATH + "placeholder3_on.png"
	},
	4: {
		"name": "trashcan",
		"asset": ICON_PATH + "trashcan.png",
		"on_asset": ICON_PATH + "trashcan_on.png"
	}
}
func get_item(item_id):
	if item_id in ITEMS:
		return ITEMS[item_id]
	else:
		return ITEMS[0]
