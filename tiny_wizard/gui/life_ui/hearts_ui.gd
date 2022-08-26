extends "res://top-down-shooter-core/gui/player_ui/player_ui.gd"

const HEART_SCENE = preload("res://demos/tiny_wizard/gui/life_ui/heart/heart.tscn")

var max_life := 0

enum {EMPTY, HALF, FULL, FULL_SHIELD, HALF_SHIELD}

@onready var heart_container = $HBoxContainer/HeartContainer
@onready var shield_container = $HBoxContainer/ShieldContainer

func _ready():
	super._ready()
	update_ui()

func update_ui():
	# label.text = "%d/%d" % [player_stats.current_life, player_stats.max_life]
	
	if player_stats.max_life != max_life:
		var difference = (player_stats.max_life - max_life)/2
		
		if difference > 0:
			for i in range(difference):
				# Create Heart
				var heart = HEART_SCENE.instantiate()
				heart_container.add_child(heart)
		else:
			var to_remove = []
			for i in range(-difference):
				to_remove.append(heart_container.get_child(i))
			for h in to_remove:
				heart_container.remove_child(h)
				h.queue_free()
		
		max_life = player_stats.max_life
		
	var life = player_stats.current_life
	
	for heart in heart_container.get_children():
		if life>=2:
			heart.set_state(FULL)
			life-=2
		elif life == 1:
			heart.set_state(HALF)
			life -= 1
		elif life <= 0:
			heart.set_state(EMPTY)
			
	var shield_count = player_stats.current_shield
	var difference = (shield_count+1) / 2 - shield_container.get_child_count()
	if difference > 0:
		for i in range(difference):
			var shield = HEART_SCENE.instantiate()
			shield_container.add_child(shield)
	else:
		var to_remove = []
		for i in range(-difference):
			to_remove.append(shield_container.get_child(i))
		for s in to_remove:
			shield_container.remove_child(s)
			s.queue_free()
	
	for shield in shield_container.get_children():
		
		if shield_count>=2:
			shield.set_state(FULL_SHIELD)
			shield_count-=2
		elif shield_count == 1:
			shield.set_state(HALF_SHIELD)
			shield_count -= 1
		elif shield_count <= 0:
			shield.set_state(EMPTY)
			
	
	
	pass
