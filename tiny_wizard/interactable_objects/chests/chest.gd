extends QuiverInteractableObject

@export var items := []

func _ready():
	super._ready()
	action.items = items
