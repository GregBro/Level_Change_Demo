extends Node

const room_1 = preload("res://Scenes/room_1.tscn")
const room_2 = preload("res://Scenes/room_2.tscn")
const room_3 = preload("res://Scenes/room_3.tscn")

signal on_trigger_player_spawn

var spawn_door_tag
var scene_to_load

var player : Player = null

func go_to_level(destination_level_tag, destination_door_tag) -> void:
	#print("Got to go_to_level")
	#print("destination_level_tag: " + str(destination_level_tag))
	#print("destination_door_tag: " + str(destination_door_tag))
	
	match destination_level_tag:
		"Room_1":
			scene_to_load = room_1
		"Room_2" :
			scene_to_load = room_2
		"Room_3" :
			scene_to_load = room_3
			
	if scene_to_load != null :
		TransitionScene.transition()
		await TransitionScene.on_transition_finished
		spawn_door_tag = destination_door_tag
		print("spawn_door_tag: " + spawn_door_tag)
		get_tree().change_scene_to_packed.bind(scene_to_load).call_deferred()
	

# The reason the player doesn't show up is because the original Player object was attached to the first room
# The Player object needs to be the same object across all scenes.  So we need to hold onto the Player object
# inside the NavigationManager
func trigger_player_spawn(position: Vector2, direction:String):
	on_trigger_player_spawn.emit(position, direction)
