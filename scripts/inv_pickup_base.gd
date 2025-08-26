extends Area2D

signal collected(body: Node)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): #this only triggers for players
		collect(body) #this calls body in this function
		collected.emit(body) #this makes the collection broadcast in case we want to listen elsewhere


func collect(body: Node) -> void:
	pass #we leave this empty since it will be overwritten in the actual inventory pieces
	
	
