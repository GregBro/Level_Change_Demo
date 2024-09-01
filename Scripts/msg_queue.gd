extends Node

signal load_room_data

func send_load_room_data(room_data) :
	load_room_data.emit(room_data)
