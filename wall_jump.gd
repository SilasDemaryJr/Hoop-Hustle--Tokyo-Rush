extends CharacterBody2D

# === Movement constants ===
const SPEED = 200
const JUMP_VELOCITY = -400
const GRAVITY = 1000
const MAX_FALL_SPEED = 700

# === Wall jump constants ===
const WALL_JUMP_X = 250
const WALL_JUMP_Y = -350
const WALL_SLIDE_SPEED = 100

# === State ===
var wall_dir = 0
var can_wall_jump = true

func _physics_process(delta):
	var input_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	# --- Horizontal movement ---
	velocity.x = input_direction * SPEED

	# --- Gravity ---
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, MAX_FALL_SPEED)

	# --- Wall detection ---
	if is_on_wall() and not is_on_floor():
		var wall_normal = Vector2.ZERO
		if get_slide_collision_count() > 0:
			var collision = get_last_slide_collision()
			if collision != null:
				wall_normal = collision.normal
		wall_dir = -sign(wall_normal.x)

		# --- Wall slide ---
		if velocity.y > WALL_SLIDE_SPEED:
			velocity.y = WALL_SLIDE_SPEED

		# --- Wall jump ---
		if Input.is_action_just_pressed("jump") and can_wall_jump:
			velocity.y = WALL_JUMP_Y
			velocity.x = WALL_JUMP_X * wall_dir
			can_wall_jump = false
	else:
		wall_dir = 0

	# --- Ground jump ---
	if is_on_floor():
		can_wall_jump = true
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY

	# --- Apply movement ---
	move_and_slide()
