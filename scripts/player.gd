extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	#flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#play animations
	
	#animations if I have time to make a jump animation.
	#if is_on_floor():
		#if direction == 0:
			#animated_sprite.play("Idle")
		#else:
			#animated_sprite.play("Move Horizontal")
	#else:
		#animated_sprite.play("Jump")
	
	if direction == 0:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Move Horizontal")
	
	#apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
