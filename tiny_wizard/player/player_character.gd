extends QuiverCharacter



var arrow_types = {
	'normal': preload("res://demos/tiny_wizard/player/weapon/bullet/arrow.tscn"),
	'violet': preload("res://demos/tiny_wizard/player/weapon/bullet/violet_arrow.tscn"),
}

func hit(damage:=1, from:=Vector2.ZERO):
	super.hit(damage, from)
	$Visual/AnimationPlayer.play("Blink")


func _process(delta):
	if Input.is_action_just_pressed("drop_bomb"):
		(inventory as QuiverInventory).use_item(self, "Bomb")
#			inventory.add_to_item('bombs', -1)
#			var bomb = BOMB_SCENE.instantiate()
#			bomb.position = position
#			get_parent().add_child(bomb)

func change_arrow(arrow_scene):
	$Visual/DistanceWeapon.bullet_scene = arrow_scene
#	inventory.current_arrow = arrow_scene.instantiate().icon
	%ArrowUITexture.texture = arrow_scene.instantiate().icon

