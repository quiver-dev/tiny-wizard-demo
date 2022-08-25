extends MarginContainer

@export var inventory : Resource # TypeFix Inventory


@onready var counters = {
	'Bomb': $VBoxContainer/Bombs/BombsCount,
	'Key': $VBoxContainer/Keys/KeysCount,
	'Coin': $VBoxContainer/Coins/CoinsCount,
}

func _ready():
	(inventory as QuiverInventory).item_changed.connect(self.item_changed)

func item_changed(item:QuiverItem):
	if counters.has(item.name):
		counters[item.name].text = str(inventory.get_item_amount(item))
