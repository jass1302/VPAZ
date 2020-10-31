extends Node

var totalGrabbedItems : int = 0
var totalGrabbedTypeOne : int = 0
var totalGrabbedTypeTwo : int = 0
var totalGrabbedTypeThree : int = 0

func _ready():
	InvHandler.connect("grabbedItem",self,"countItem")

func countItem(tipo):
	print("GOT IT")
	totalGrabbedItems += 1
	match tipo:
		1:
			totalGrabbedTypeOne += 1
		2:
			totalGrabbedTypeTwo += 1
		3:
			totalGrabbedTypeThree += 1

func getTotalGrabbed() -> int:
	return totalGrabbedItems

func getTotalGrabbedOne() -> int:
	return totalGrabbedTypeOne

func getTotalGrabbedTwo() -> int:
	return totalGrabbedTypeTwo

func getTotalGrabbedThree() -> int:
	return totalGrabbedTypeThree
