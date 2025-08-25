extends "res://scripts/inv_pickup_base.gd"

@onready var animations = $AnimationPlayer

func collect():
	animations.play("spin")
	await animations.animation_finished
	
