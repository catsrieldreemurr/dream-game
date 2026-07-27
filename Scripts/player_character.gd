extends CharacterBody2D

# I HATE THIS 

const SPEED = 600.0
const JUMP_VELOCITY = -600.0

@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 1.5 * delta 

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("moveLeft", "moveRight")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Change Sprite Direction
	if direction < 0:
		sprite_2d.flip_h = true;
	elif direction > 0:
		sprite_2d.flip_h = false;

	move_and_slide()
