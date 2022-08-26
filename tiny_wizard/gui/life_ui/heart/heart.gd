extends TextureRect

enum {EMPTY, HALF, FULL, FULL_SHIELD, HALF_SHIELD}

var textures = [
	preload("res://tiny_wizard/assets/placeholder_art/gui/empty_heart.png"),
	preload("res://tiny_wizard/assets/placeholder_art/gui/half_heart.png"),
	preload("res://tiny_wizard/assets/placeholder_art/gui/heart.png"),
	preload("res://tiny_wizard/assets/placeholder_art/gui/shield.png"),
	preload("res://tiny_wizard/assets/placeholder_art/gui/half_shield.png"),
]

func set_state(state):
	texture = textures[state]

