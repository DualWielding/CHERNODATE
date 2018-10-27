extends KinematicBody2D

const GRAVITY = 700.0
const SPEED = 200.0
const INITIAL_JUMP = 250.0
const MAX_JUMP = 500.0
const JUMP_INCREMENT = 50.0
var jump_numbers = 0
var max_jumps = 2
var velocity = Vector2()

var is_jumping = false

func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	velocity.x += delta * SPEED
	
	if is_jumping and velocity.y > -MAX_JUMP:
		velocity.y -= JUMP_INCREMENT
	else:
		is_jumping = false
	
	var motion = velocity * delta
	motion = move(motion)

	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
		
		if motion.y == 0:
			jump_numbers = 0

func _input(event):
	if event.is_action_pressed("jump") and jump_numbers < max_jumps:
		velocity.y -= INITIAL_JUMP
		jump_numbers += 1
		is_jumping = true
	if event.is_action_released("jump"):
		is_jumping = false
		velocity.y += INITIAL_JUMP / 1.5

func _ready():
	set_fixed_process(true)
	get_node("AnimationPlayer").play("Run1")
	set_process_input(true)