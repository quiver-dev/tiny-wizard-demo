extends Node2D

const ROOM_SIZE = Vector2(1024,600)

var _current_room := Vector2i.ZERO

var rooms = {}

func _ready():
	for room in $Rooms.get_children():
		room.door_entered.connect(self.move_camera)
		
		var room_pos = Vector2i((room.global_position - Vector2(0,200)) / ROOM_SIZE)
		rooms[room_pos] = room
		
		pass
	for room_pos in rooms:
		var room = rooms[room_pos]
		room.hide_right_door = !rooms.has(room_pos + Vector2i.RIGHT)
		room.hide_down_door = !rooms.has(room_pos + Vector2i.DOWN)
		room.hide_left_door = !rooms.has(room_pos + Vector2i.LEFT)
		room.hide_up_door = !rooms.has(room_pos + Vector2i.UP)
		room.update_doors()


func move_camera(direction):
	_current_room += Vector2i(direction)
	$Camera2D.position += direction*ROOM_SIZE
	var next_room = get_room(_current_room)
	$Character.global_position = next_room.get_spawning_point(direction).global_position
	next_room.enter_room()


func get_room(room_coord: Vector2i):
	if rooms.has(room_coord):
		return rooms[room_coord]
	else:
		return null
