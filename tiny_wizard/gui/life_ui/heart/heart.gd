extends TextureRect

enum {EMPTY, HALF, FULL, FULL_SHIELD, HALF_SHIELD}

var textures = [
	preload("res://demos/tiny_wizard/assets/placeholder_art/gui/EmptyHeart.png"),
	preload("res://demos/tiny_wizard/assets/placeholder_art/gui/HalfHeart.png"),
	preload("res://demos/tiny_wizard/assets/placeholder_art/gui/Heart.png"),
	preload("res://demos/tiny_wizard/assets/placeholder_art/gui/Shield.png"),
	preload("res://demos/tiny_wizard/assets/placeholder_art/gui/HalfShield.png"),
]

func set_state(state):
	texture = textures[state]

