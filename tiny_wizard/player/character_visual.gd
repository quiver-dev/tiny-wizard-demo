extends QuiverCharacterVisual


# This is a Visual meant to be used with an AnimatedSprite2D node
# The animations should be named "0" "1" "2"... each animation coresponding to a rotation of the character
# The animation "0" should be the enemy facing right
# The next animations represents the character rotated in clockwise order

enum RotationMode {NONE, AIMING, MOVING}

# Will the character rotate on aiming or moving ?
@export var rotation_mode : RotationMode = RotationMode.AIMING

# How many different angles do you want your character to rotate
# You will need to have a walking animation for each angle
@export var rotation_clamping := 4

@onready var head: AnimatedSprite2D = $Head
@onready var body: AnimatedSprite2D = $Body
@onready var hat: Sprite2D = $Hat

@onready var weapon = $DistanceWeapon


func update_visual(action: QuiverCharacterAction):
	
	if action.moving_direction.length() > 0:
		body.play()
	else:
		body.stop()
		body.frame = 0 # The standing/idle frame
	
	if action.moving_direction.length() > 0:
		body.scale = Vector2(int(action.moving_direction.x>=0)*2-1,1)
		_apply_body_rotation(action.moving_direction.angle())
	
	if action.aiming_direction.length() > 0:
		_apply_head_rotation(action.aiming_direction.angle())
	else:
		if !head.is_playing():
			head.frame = 0
			head.animation = 'default'
			hat.scale = Vector2.ONE
			hat.position = Vector2(-1.667,-128.33)
			

func _apply_body_rotation(angle):
	var k = int(round(angle/(2*PI/rotation_clamping)))
	k = (k+rotation_clamping)%rotation_clamping
	if body.animation != 'move_' + str(k):
		body.frame = 1
	body.animation = 'move_' + str(k)

func _apply_head_rotation(angle):
	var k = int(round(angle/(2*PI/rotation_clamping)))
	k = (k+rotation_clamping)%rotation_clamping
	if head.animation != 'shoot_' + str(k) or !head.is_playing():
		# Orientate weapon
		weapon.shoot_direction = Vector2.RIGHT.rotated((k*2*PI)/rotation_clamping)
		
		head.frame = 0
		head.play('shoot_' + str(k))
	

	hat.scale = Vector2(int(k!=2)*2-1,1)
	hat.position = Vector2(-1.667 + int(k==2)*12.0,-128.33)


func _on_head_animation_finished():
	head.stop()
