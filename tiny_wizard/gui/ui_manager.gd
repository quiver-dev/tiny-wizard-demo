extends CanvasLayer


@export var inventory : Resource # TypeFix Inventory


func change_arrow_texture(new_texture):
	%ArrowUITexture.texture = new_texture
