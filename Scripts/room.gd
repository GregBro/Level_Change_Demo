extends Node

class_name Room

@onready var player_packed_scene = preload("res://Scenes/player.tscn")
var player : Player = null

func _ready() -> void:
	if NavigationManager.player != null:
		add_child(NavigationManager.player)
	else :
		player = player_packed_scene.instantiate()
		NavigationManager.player = player
		add_child(player)

	if NavigationManager.spawn_door_tag != null :
		_on_level_spawn(NavigationManager.spawn_door_tag)


func _on_level_spawn(spawn_door_tag):
	var door_path = "Doors/Door_" + spawn_door_tag
	var door = get_node(door_path) as Door # Very important to cast it to a Door object
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
