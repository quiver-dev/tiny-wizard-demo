extends QuiverCharacterBehavior


const CHANGE_DIRECTION_TIME = 2.0

var _t := randf()*CHANGE_DIRECTION_TIME

var _random_movement := Vector2.ZERO
var _player_movement := Vector2.ZERO

@onready var player_detector := $PlayerDetector 

func _process(delta):
	_t -= delta
	if _t <= 0:
		_random_movement = Vector2.RIGHT.rotated(randf()*2*PI) 
		_t = CHANGE_DIRECTION_TIME
	
	if player_detector.player_is_in_range():
		_player_movement = 0.33*global_position.direction_to(player_detector.get_player_position())
	else:
		_player_movement = Vector2.ZERO
	
	action.moving_direction = _random_movement + 5*_player_movement

