extends "res://scripts/inv_pickup_base.gd"

func collect(body: Node) -> void:
	if body.has_method("heal"):
		body.heal(50)
	queue_free()
