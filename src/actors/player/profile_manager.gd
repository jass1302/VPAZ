extends Node2D

export var username: String
export(String,"Seleccionar", "Male", "Female") var gender

func getUsername() -> String:
	return username

func getGender() -> String:
	return gender

func save() -> Dictionary:
	print("running")
	var save_dic = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"username": username,
		"gender": gender
	}
	return save_dic
