extends CharacterBody2D

const GRAVITY = 980
const WALK_SPEED = 100
const JUMP_SPEED = 250
const WALL_JUMP_INTERVAL = 0.2
const MAX_SPEED = 150

# TODO -> Variable jump height based on how long jump button held
# TODO -> Inertia/friction on horizontal movement
# TODO -> Dash/roll/slide ability

func _physics_process(delta: float) -> void:
	# Gravity
	velocity.y += delta * GRAVITY
	
	# Move
	if is_on_floor():
		if Input.is_action_pressed("left"):
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("right"):
			velocity.x =  WALK_SPEED
		else:
			velocity.x = 0
	else:
		if Input.is_action_pressed("left") and velocity.x > -MAX_SPEED:
			velocity.x -= WALK_SPEED * 0.2
		elif Input.is_action_pressed("right") and velocity.x < MAX_SPEED:
			velocity.x +=  WALK_SPEED * 0.2
	
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMP_SPEED
	
	# Wall Jump
	if is_on_wall_only() and Input.is_action_just_pressed("jump"):
		velocity.y = 0
		velocity.y -= JUMP_SPEED * 0.8
		velocity.x += JUMP_SPEED * 0.5 * get_wall_normal().x
	
	move_and_slide()
