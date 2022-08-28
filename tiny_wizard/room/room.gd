@tool
extends Node2D

const ROOM_SIZE = Vector2(1024,600)

enum Direction {RIGHT, DOWN, LEFT, UP}
enum Status {UNEXPLORED, EXPLORED}

const OPEN_DOORS = [
	preload("res://tiny_wizard/assets/placeholder_art/Doors/right_door.png"),
	preload("res://tiny_wizard/assets/placeholder_art/Doors/down_door.png"),
	preload("res://tiny_wizard/assets/placeholder_art/Doors/left_door.png"),
	preload("res://tiny_wizard/assets/placeholder_art/Doors/up_door.png"),
]

const CLOSED_DOORS = [
	preload("res://tiny_wizard/assets/placeholder_art/Doors/right_door_closed.png"),
	preload("res://tiny_wizard/assets/placeholder_art/Doors/down_door_closed.png"),
	preload("res://tiny_wizard/assets/placeholder_art/Doors/left_door_closed.png"),
	preload("res://tiny_wizard/assets/placeholder_art/Doors/up_door_closed.png"),
]

@onready var doors = [
	$RoomWalls/RightDoor,
	$RoomWalls/DownDoor,
	$RoomWalls/LeftDoor,
	$RoomWalls/UpDoor,
]

@onready var spawn_points = [
	$RightSpawnPoint,
	$DownSpawnPoint,
	$LeftSpawnPoint,
	$UpSpawnPoint,
]


@export var hide_right_door := false
@export var hide_down_door := false
@export var hide_left_door := false
@export var hide_up_door := false

var room_pos := Vector2i.ZERO

signal door_entered(direction)

# Get the position of the room on the level matrix: (0,0), (0,1)...
func get_room_matrix_position()->Vector2i:
	return room_pos

func get_room_global_position()->Vector2:
	return global_position

func get_room_rect()->Rect2:
	return Rect2(
		global_position,
		ROOM_SIZE
	)

func update_doors():
	if hide_right_door: _hide_door(Direction.RIGHT)
	if hide_down_door: _hide_door(Direction.DOWN)
	if hide_left_door: _hide_door(Direction.LEFT)
	if hide_up_door: _hide_door(Direction.UP)

func get_spawning_point(direction):
	var dir = Direction.UP
	if direction.x > 0:
		dir = Direction.RIGHT
	if direction.y > 0:
		dir = Direction.DOWN
	if direction.x < 0:
		dir = Direction.LEFT
	
	return spawn_points[dir]

func enter_room():
	var enemies = $Enemies.get_children()
	if enemies.size() > 0:
		# Close doors
		
		
		for enemy in enemies:
			enemy.set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
		
		for d in [Direction.RIGHT, Direction.DOWN, Direction.LEFT, Direction.UP]:
			close_door(d)
		
		pass

func enter_door(_body, door_direction):
	door_entered.emit(door_direction)

func _hide_door(direction):
	var door = doors[direction]
	door.get_node("Locker").collision_layer = 1
	door.visible = false

func close_door(direction:Direction):
	doors[direction].texture = CLOSED_DOORS[direction]
	(doors[direction].get_node("Locker") as StaticBody2D).collision_layer = 1

func open_door(direction:Direction):
	doors[direction].texture = OPEN_DOORS[direction]
	(doors[direction].get_node("Locker") as StaticBody2D).collision_layer = 0


func _on_enemies_child_exiting_tree(node):
	# If it is the last enemy (see godotengine/godot #59210)
	if $Enemies.get_child_count() == 1:
		for d in [Direction.RIGHT, Direction.DOWN, Direction.LEFT, Direction.UP]:
			open_door(d)

