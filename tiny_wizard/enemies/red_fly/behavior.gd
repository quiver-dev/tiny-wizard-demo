extends QuiverCharacterBehavior


const SPEED = .6
const CHANGE_DIRECTION_TIME = 1.0
var _t := randf()*CHANGE_DIRECTION_TIME

func _process(delta):
	_t -= delta
	if _t <= 0:
		action.moving_direction = Vector2.RIGHT.rotated(randf()*2*PI)
		_t = CHANGE_DIRECTION_TIME
