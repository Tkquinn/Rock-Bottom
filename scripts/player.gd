extends CharacterBody2D

@export var accelerationValue = 0.01
@export var slideValue = 0.01
@export var fullStopValue = 20

const SPEED = 100.0
const JUMP_VELOCITY = -250.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_ray_cast: RayCast2D = $floorRayCast
@onready var floor_ray_cast_2: RayCast2D = $floorRayCast2

var platVel = Vector2(0,0)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	if _is_on_moss():
		_movement_on_moss(direction)
	else:
		_normal_movement(direction)
	
	#flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#play animations
	
	#animation code if I have time to make a jump animation.
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
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _movement_on_moss(direction):
	if direction:
		velocity.x =  lerp(velocity.x, direction * SPEED, accelerationValue)
	else:
		velocity.x = lerp(velocity.x, 0.0, slideValue)
		if velocity.x < fullStopValue and velocity.x > -fullStopValue:
			velocity.x = 0

func _normal_movement(direction):
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _is_on_moss():
	var collider = floor_ray_cast.get_collider()
	var collider2 = floor_ray_cast_2.get_collider()
	if not collider:
		if not collider2:
			return false
		return collider2.name == "mossy"
	return collider.name == "mossy"
