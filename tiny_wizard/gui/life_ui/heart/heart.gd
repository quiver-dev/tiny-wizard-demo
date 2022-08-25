extends TextureRect

enum {EMPTY, HALF, FULL, FULL_SHIELD, HALF_SHIELD}

var textures = [
	preload("res://demos/tiny_wizard/assets/placeholder_art/GUI/EmptyHeart.png"),
	preload("res://demos/tiny_wizard/assets/placeholder_art/GUI/HalfHeart.png"),
	preload("res://demos/tiny_wizard/assets/placeholder_art/GUI/Heart.png"),
	preload("res://demos/tiny_wizard/assets/placeholder_art/GUI/Shield.png"),
	preload("res://demos/tiny_wizard/assets/placeholder_art/GUI/HalfShield.png"),
]

func set_state(state):
	texture = textures[state]

