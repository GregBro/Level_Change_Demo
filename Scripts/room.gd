extends Node

class_name Room

@onready var player_packed_scene = preload("res://Scenes/player.tscn")
var player : Player = null

func _ready() -> void:
	var level_data = NavigationManager.level_dictionary[0]
	load_date_from_dictionary(level_data.Rooms[NavigationManager.current_room])
#	TODO Move this to Globals
	if NavigationManager.player != null:
		add_child(NavigationManager.player)
	else :
		player = player_packed_scene.instantiate()
		NavigationManager.player = player
		add_child(player)

	if NavigationManager.spawn_door_tag != null :
		_on_level_spawn(NavigationManager.spawn_door_tag)


func _on_level_spawn(spawn_door_tag):
	var door_path = "Door_" + spawn_door_tag
	var doors_node = get_node("Doors")
	var door = doors_node.get_node(door_path) as Door # Very important to cast it to a Door object
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)

func load_date_from_dictionary(level_data):
	var room_floor = get_node("Floor")
	room_floor.set_color(level_data.Room_Color)
	var doors_node = get_node("Doors")
	var door_array = level_data.Doors
	print(door_array)
	load_door_data(doors_node,door_array)

func load_door_data(doors_node,door_array) :
	if doors_node.find_child("Door_n") :
		setup_door_data(door_array,doors_node.get_node("Door_n"), "n")
	if doors_node.find_child("Door_s") :
		setup_door_data(door_array,doors_node.get_node("Door_s"), "s")
	if doors_node.find_child("Door_e") :
		setup_door_data(door_array,doors_node.get_node("Door_e"), "e")
	if doors_node.find_child("Door_w"):
		setup_door_data(door_array,doors_node.get_node("Door_w"), "w")

func setup_door_data(door_array,door_node, suffix) :
		var door_data = get_door_data(door_array, "Door_" + suffix)
		if door_data != null :
			door_node.destination_level_tag = door_data.Destination_Level_Tag
			door_node.destination_door_tag = door_data.Destination_Door_Tag
			door_node.spawn_direction = door_data.Spawn_Direction
	

func get_door_data(door_array, door_name) :
	var door_data
	for n in door_array :
		if n.Name == door_name :
			door_data = n
			
	return door_data
	
