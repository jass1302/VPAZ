extends Position2D

#### Variables ####

func select(x: int):
	
	InvHandler.disposeItem(x,get_tree().get_nodes_in_group("depositUI")[0].tipo)
	get_tree().get_nodes_in_group("depositUI")[0].updateUI()
func deselect():
	pass
