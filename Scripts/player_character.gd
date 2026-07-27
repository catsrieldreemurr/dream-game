extends CharacterBody2D

# I HATE THIS 

const SPEED = 600.0
const JUMP_VELOCITY = -600.0

@onready var sprite_2d: Sprite2D = $Sprite2D

var flyModeEnabled = true # False = Jump, True = Fly

func jump():
	if flyModeEnabled == false: # Jump Mode
		if Input.is_action_just_pressed("Jump"):
			velocity.y = JUMP_VELOCITY
	elif flyModeEnabled == true: # Fly Mode
		if Input.is_action_pressed("Jump"):
			velocity.y = -400

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if flyModeEnabled == false:
			velocity += get_gravity() * 1.5 * delta 
		else:
			velocity.y = 0 

	# Handle jump.
	jump()

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("moveLeft", "moveRight")
	var yDirection := Input.get_axis("Jump", "flyDown")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if flyModeEnabled:
		velocity.y = yDirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	# Change Sprite Direction
	if direction < 0:
		sprite_2d.flip_h = true;
	elif direction > 0:
		sprite_2d.flip_h = false;

	move_and_slide()
