extends QuiverCharacterVisual


var _t := 0.0


func _process(delta):
	_t+=delta
	$AnimatedSprite2D.position.y = -52+1.2*sin(8*_t)
	
