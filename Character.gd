extends KinematicBody2D

const GRAVITY = 2500.0
const SPEED = 200.0
const INITIAL_JUMP = 500.0
const MAX_JUMP = 750.0
const JUMP_INCREMENT = 100.0
const MAX_SPEED = 850.0
var jump_numbers = 0
var max_jumps = 2
var velocity = Vector2()

var is_jumping = false

var rads = 0.0

func _process(delta):
	if rads < 100.0:
		rads += delta
	else:
		rads = 100.0

func _fixed_process(delta):
	if velocity.x < MAX_SPEED:
		velocity.x += delta * SPEED
	
	velocity.y += delta * GRAVITY
	if is_jumping and velocity.y > -MAX_JUMP:
		velocity.y -= JUMP_INCREMENT
	else:
		# Adds weight to the end of the jump
		if velocity.y < -MAX_JUMP and is_jumping:
			velocity.y += INITIAL_JUMP / 1.5
		is_jumping = false
	
	var motion = velocity * delta
	motion = move(motion)

	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
		
		# hit the ground
		if motion.y == 0:
			if jump_numbers > 0:
				get_node("AnimationPlayer").play("Run1")
			jump_numbers = 0

func _input(event):
	if event.is_action_pressed("jump") and jump_numbers < max_jumps:
		get_node("AnimationPlayer").play("Jump")
		velocity.y -= INITIAL_JUMP
		jump_numbers += 1
		is_jumping = true
	if event.is_action_released("jump") and is_jumping:
		is_jumping = false
		velocity.y += INITIAL_JUMP / 1.5

func _ready():
	set_fixed_process(true)
	set_process(true)
	set_process_input(true)
	get_node("AnimationPlayer").play("Run1")

func get_rads():
	return rads

func get_speed():
	return velocity.x

func affect_speed(value, should_bump):
	var new_velocity =  velocity.x + value
	if new_velocity < 0:
		if should_bump:
			velocity.x = new_velocity
		else:
			velocity.x = 0
	else:
		velocity.x = new_velocity

func affect_rads(value):
	rads += value
	if rads < 0:
		rads = 0
	elif rads > 100:
		rads = 100