extends QuiverInteractableObjectAction

# The items to spawn (an array of QuiverPickableItem packed scenes)
var items := [] 
# The path to the sprite to change it's texture to open
@export var chest_sprite: NodePath
# Enable this to create a locked chest that will consume a key to open
@export var locked:= false

@onready var chest = get_node(chest_sprite)

func _ready():
	pass

func trigger(object: QuiverInteractableObject, character: QuiverCharacter):
	var next_action = get_node_or_null("OnFailure")

	if active:
		if character.can_grab_items:
			
			if locked:
				if (character.inventory as QuiverInventory).get_item_amount("Key") > 0:
					character.inventory.remove_item("Key")
				else:
					# We cannot open it so we stop here
					if next_action is QuiverInteractableObjectAction:
						# Trigger next action
						next_action.trigger(object, character)
					return
			
			# Opening the chest
			next_action = get_node_or_null("OnSuccess")
			# We don't want to open again after
			active = false
			# Visual opening
			chest.open()
			# Spawn items
			for item in items:
				if item is QuiverItem:
					var item_node = item.create_pickable_item()
					item_node.position = object.position + chest.get_parent().position
					object.call_deferred("add_sibling", item_node)
	
	if next_action is QuiverInteractableObjectAction:
		# Trigger next action
		next_action.trigger(object, character)
