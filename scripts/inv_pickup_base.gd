extends Area2D

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	print("will this finally fuckin work")
