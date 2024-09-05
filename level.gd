extends Node2D


func _ready() -> void:
	
	NavigationManager.load_data_dictionary("res://dataLibrary/level_2_room_data.json")
	NavigationManager.go_to_level(0,"n")
