extends Node

var saveDir: String = "user://game_saves/"

##Profile
var username : String
var gender : String

##Inv_Handler
var max_slots
var items
var lastIndex


func save() -> void:
	pass

# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables.
func save_game(curr_scn: String) -> void:
	var file = File.new()
	var directory: Directory = Directory.new()
	
	directory.make_dir_recursive(saveDir)
	file.open(saveDir+"%s.save" % ProfileManager.getUsername(), File.WRITE)
	
	var save_nodes = get_tree().get_nodes_in_group("persistent")
	var scns_data = {}
	
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		scns_data[curr_scn] = node.save()

		# Store the save dictionary as a new line in the save file.
		file.store_line(to_json(scns_data))
	file.close()

func load_game(curr_scn: String) -> bool:
	var save_file = File.new()
	if not save_file.file_exists(saveDir+"%s.save" % ProfileManager.getUsername()):
		print("Error. No se encontró el archivo de guardado.")
		return false

	var persistent_nodes = get_tree().get_nodes_in_group("persistent")
	
	for i in persistent_nodes:
		##Aquí se agregan aquellos nodos que queremos que no se eliminen
		## ej. if i.is_in_group("player"): continue
		if i.is_in_group("profile"): continue
		
		if i.is_in_group("inventory"): continue
		i.queue_free() ##Se eliminan todos los nodos persistentes antes de reinstancearlos
		
	save_file.open(saveDir+"%s.save" %curr_scn, File.READ) ##Abrimos el archivo de guardado
	
	##Iteramos en las lineas del archivo de guardado, las cuales representan los nodos guardados
	while save_file.get_position() < save_file.get_len():
	##Node_data guarda la información de una linea del JSON, la cual representa un nodo a reinstanciar
		var node_data = parse_json(save_file.get_line())
		##Se crea un nuevo nodo con la información del archivo
		var new_object = load(node_data[curr_scn]["filename"]).instance()
		## if new_object.is_in_group("Player"): new_object.queue_free()
		if new_object.is_in_group("profile"):
			new_object.queue_free()
			ProfileManager.username = node_data[curr_scn]["username"]
			ProfileManager.gender = node_data[curr_scn]["gender"]
			continue

		if new_object.is_in_group("Player"):
			new_object.position.x = node_data[curr_scn]["pos_x"]
			new_object.position.y = node_data[curr_scn]["pos_y"]

		if new_object.is_in_group("inventory"):
			new_object.queue_free()
			InvHandler.max_slots = node_data[curr_scn]["max_slots"]
			InvHandler.items = node_data[curr_scn]["inventory"]
			InvHandler.lastIndex = node_data[curr_scn]["lastIndex"]
			continue
			
		get_node(node_data[curr_scn]["parent"]).add_child(new_object)
	
	save_file.close()
	return true
