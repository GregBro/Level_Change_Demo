extends CharacterBody2D

class_name Player

const SPEED = 300.0

enum face_direction {up,down,left,right}

func _ready() -> void:
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction.x = direction.x 
	direction.y = direction.y 
	velocity = direction * SPEED 
	move_and_slide()

func set_face_direction(face_direction_input):
	match face_direction_input :
		"up" 	: rotation_degrees = 180
		"down" 	: rotation_degrees = 0
		"right" : rotation_degrees = 270
		"left" 	: rotation_degrees = 90
		
func _on_spawn(spawn_position: Vector2, face_direction_string: String) :
	print("Got to _on_spawn")
	global_position = spawn_position
	set_face_direction(face_direction_string)
