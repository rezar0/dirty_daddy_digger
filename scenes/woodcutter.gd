extends CharacterBody2D

const SPEED = 130.0
const SPRINT_VALUE = 1.5

enum PlayerState { IDLE, WALK, SPRINT, ATTACK }
var state: PlayerState = PlayerState.IDLE

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var current_anim: String = ""

func _ready() -> void:
	# Connect animation_finished signal in code (or in the editor)
	animated_sprite.animation_finished.connect(_on_animation_finished)

func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# input_vector is a Vector2 with values like (0, -1), (1, 0), (1, -1), etc.
	
	# Flip sprite (based on horizontal motion only)
	if input_vector.x > 0:
		animated_sprite.flip_h = false
	elif input_vector.x < 0:
		animated_sprite.flip_h = true

	# ---- Attack input ----
	if Input.is_action_just_pressed("mb_left") and state != PlayerState.ATTACK:
		state = PlayerState.ATTACK
		velocity = Vector2.ZERO
		_set_animation("attack_one")

	match state:
		PlayerState.ATTACK:
			# No movement allowed while attacking
			pass

		PlayerState.WALK, PlayerState.SPRINT, PlayerState.IDLE:
			if input_vector != Vector2.ZERO:
				velocity = input_vector.normalized() * SPEED
				if Input.is_action_pressed("sprint"):
					velocity *= SPRINT_VALUE
					state = PlayerState.SPRINT
					_set_animation("sprint")
				else:
					state = PlayerState.WALK
					_set_animation("walk")
			else:
				velocity = velocity.move_toward(Vector2.ZERO, SPEED)
				state = PlayerState.IDLE
				_set_animation("idle")

	move_and_slide()


func _set_animation(anim: String) -> void:
	if current_anim != anim:
		current_anim = anim
		animated_sprite.play(anim)

func _on_animation_finished() -> void:
	# Only release from attack after the attack anim is finished
	if state == PlayerState.ATTACK:
		state = PlayerState.IDLE
