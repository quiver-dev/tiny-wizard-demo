extends QuiverItemUseAction
class_name QuiverItemUseActionEquipBullet

# A custom QuiverItemUseAction to change the current weapon arrow

# The bullet packed scene
@export var bullet_scene: PackedScene

func use(user: QuiverCharacter)->bool:
	if user.has_method('change_arrow'):
		user.change_arrow(bullet_scene)
	return true
