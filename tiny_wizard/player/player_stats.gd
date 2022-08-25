extends QuiverCharacterStats

# This extension adds shield to the character stats

var current_shield := 0:
	set(value):
		if value < 0:
			value = 0
		current_shield = value
		stats_changed.emit()


# Redefine damage to take into consideration the shield
func damage(amount:int):
	if current_shield > 0:
		amount -= current_shield
		
		if amount > 0:
			current_shield = 0
			super.damage(amount)
		else:
			current_shield = -amount
		
	else:
		super.damage(amount)
