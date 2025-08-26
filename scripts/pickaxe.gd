extends "res://scripts/inv_pickup_base.gd"

@onready var animations = $AnimationPlayer

func collect(body: Node) -> void:
	animations.play("spin")
	
	# get the exact length of the animation
	var anim_length = animations.get_animation("spin").length
	print(anim_length)
	await get_tree().create_timer(anim_length).timeout
	
	queue_free()
