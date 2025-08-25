extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const SPRINT_VALUE = 3

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
		# Handle sprint
		if Input.is_action_pressed("sprint") && direction:
			velocity.x = direction * SPEED * SPRINT_VALUE
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# Handle sprint
		if Input.is_action_pressed("sprint") && direction:
			velocity.x = move_toward(velocity.x, 0, SPEED) * SPRINT_VALUE

	move_and_slide()
