extends QuiverCharacterBehavior


# returns the player input movement direction
func _get_moving_input()->Vector2:
	return Input.get_vector("player_left", "player_right", "player_up", "player_down")

# returns the player input aiming direction
func _get_aiming_input()->Vector2:
	return Input.get_vector("player_shoot_left", "player_shoot_right", "player_shoot_up", "player_shoot_down")


func _physics_process(delta):
	action.moving_direction = _get_moving_input()
	action.aiming_direction = _get_aiming_input()
	action.shoot = action.aiming_direction.length() > 0

