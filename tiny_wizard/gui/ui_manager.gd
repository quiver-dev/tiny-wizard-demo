extends CanvasLayer


@export var inventory : Resource # TypeFix Inventory


func arrow_changed():
	$TopUI/TextureRect/HBoxContainer/MarginContainer/HBoxContainer/ArrowBox/Arrow.texture = inventory.current_arrow
