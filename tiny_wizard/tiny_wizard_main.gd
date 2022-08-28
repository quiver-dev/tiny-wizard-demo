extends Node2D



var _current_room := Vector2i.ZERO

var rooms = {}

func _ready():
	for room in $Rooms.get_children():
		room.door_entered.connect(self.move_camera)
		
		var room_pos = Vector2i((room.global_position - Vector2(0,200)) / room.ROOM_SIZE)
		rooms[room_pos] = room
		room.room_pos = room_pos
		
	for room_pos in rooms:
		var room = rooms[room_pos]
		room.hide_right_door = !rooms.has(room_pos + Vector2i.RIGHT)
		room.hide_down_door = !rooms.has(room_pos + Vector2i.DOWN)
		room.hide_left_door = !rooms.has(room_pos + Vector2i.LEFT)
		room.hide_up_door = !rooms.has(room_pos + Vector2i.UP)
		room.update_doors()


func move_camera(direction):
	
	_current_room += Vector2i(direction)
	var next_room = get_room(_current_room)
	print(
		"Entering Room ", get_current_room().get_room_matrix_position(), 
		" at position ", get_current_room().get_global_position(),
		" covering area ", get_current_room().get_room_rect()
		)
	$Camera2D.position += direction*next_room.ROOM_SIZE
	$Character.global_position = next_room.get_spawning_point(direction).global_position
	next_room.enter_room()


func get_room(room_coord: Vector2i):
	if rooms.has(room_coord):
		return rooms[room_coord]
	else:
		return null

func get_current_room():
	return get_room(_current_room)
