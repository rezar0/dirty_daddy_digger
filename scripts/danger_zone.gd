extends Area2D

@export var damage_per_second: int = 5
var bodies_in_zone: Array = []
var _damage_cooldown: float = 1.0

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		bodies_in_zone.append(body)

func _on_body_exited(body: Node) -> void:
	bodies_in_zone.erase(body)

func _process(delta: float) -> void:
	if bodies_in_zone.is_empty():
		return

	_damage_cooldown -= delta
	if _damage_cooldown <= 0.0:
		for body in bodies_in_zone:
			if body.has_method("damage"):
				body.damage(damage_per_second)
		_damage_cooldown = 1.0
