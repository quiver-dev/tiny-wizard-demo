extends Node2D

const TILE_MAP_RANGE = 40

var active = true

var stone_rids = []
#func _ready():
#	play_anim()

func explode():
#	if !active: return
#
#	# Eplode Bomb
#	active = false
	
	play_anim()
	
	var exploding_area : Area2D = $RigidBody2D/ExplodingArea
	
	var explode_position = $RigidBody2D.global_position
	
	for thing in exploding_area.get_overlapping_bodies():
		if thing != $RigidBody2D:
			if thing is TileMap:
				update_tilemap(thing)

			if thing.has_method("hit"):
				thing.hit(2, explode_position.direction_to(thing.global_position))
			elif thing.has_method("apply_impulse"):
				thing.apply_impulse(explode_position.direction_to(thing.global_position)*20000/explode_position.distance_to(thing.global_position))

func update_tilemap(tilemap: TileMap):
	for stone_rid in stone_rids:
		var coords = tilemap.get_coords_for_body_rid(stone_rid)
		tilemap.set_cell(0, coords, 0, Vector2i(4,2))

func play_anim():
	($RigidBody2D/AnimatedSprite2D as AnimatedSprite2D).play("explosion")

func queue_free():
	var ground_trace = $RigidBody2D/GroundBombTrace
	var pos = ground_trace.global_position
	ground_trace.get_parent().remove_child(ground_trace)
	add_sibling(ground_trace)
	ground_trace.global_position = pos
	super.queue_free()



func _on_exploding_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is TileMap:
		stone_rids.append(body_rid)


func _on_exploding_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body is TileMap:
		var index = stone_rids.find(body_rid)
		if index >= 0:
			stone_rids.remove_at(index)
