extends TextureProgressBar

@export var player: NodePath  # export the NodePath to assign in Inspector
var player_node: Node         # will hold the actual Player node

func _ready() -> void:
	if player != null:
		player_node = get_node(player) as Player  # cast to Player type
		# initialize the bar
		value = player_node.currentHealth
		max_value = player_node.maxHealth

func _process(delta: float) -> void:
	if player_node != null:
		# smoothly-ish animate the bar toward current health
		value = lerp(value, float(player_node.currentHealth), 5 * delta)
