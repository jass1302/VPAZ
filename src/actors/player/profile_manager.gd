extends Node2D

export var username: String
export(String,"Seleccionar", "Male", "Female") var gender
var profileIcon: String = "Perrito"

var obtainedBadges: Array = [
	false, false, false, false,
	false, false, false, false, false,
	false, false, false, false, false]


func getUsername() -> String:
	return username

func getGender() -> String:
	return gender

func save() -> Dictionary:
	var save_dic = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"username": username,
		"gender": gender
	}
	return save_dic
