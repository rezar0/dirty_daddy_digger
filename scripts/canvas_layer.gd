extends CanvasLayer

@onready var inventory = $InventoryGUI

func _ready():
	inventory.close()

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		inventory.open()
	elif event.is_action_released("toggle_inventory"):
		inventory.close()
