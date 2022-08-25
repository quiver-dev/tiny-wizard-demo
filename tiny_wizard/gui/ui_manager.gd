extends CanvasLayer


@export var inventory : Resource # TypeFix Inventory

func _ready():
#	(inventory as BindingInventory).arrow_changed.connect(self.arrow_changed)
	pass

func arrow_changed():
	$TopUI/TextureRect/HBoxContainer/MarginContainer/HBoxContainer/ArrowBox/Arrow.texture = inventory.current_arrow
