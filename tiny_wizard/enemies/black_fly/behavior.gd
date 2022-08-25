extends QuiverCharacterBehavior


const CHANGE_DIRECTION_TIME = 2.0

var _target_player = null
var _t := randf()*CHANGE_DIRECTION_TIME

var _random_movement := Vector2.ZERO
var _player_movement := Vector2.ZERO

func _process(delta):
	_t -= delta
	if _t <= 0:
		_random_movement = Vector2.RIGHT.rotated(randf()*2*PI) 
		_t = CHANGE_DIRECTION_TIME
	
	if _target_player != null:
		_player_movement = 0.33*global_position.direction_to(_target_player.global_position)
	else:
		_player_movement = Vector2.ZERO
	
	action.moving_direction = _random_movement + 5*_player_movement


func _on_player_detection_area_body_entered(body):
	_target_player = body


func _on_player_detection_area_body_exited(body):
	_target_player = null
