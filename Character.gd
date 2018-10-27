extends KinematicBody2D

const GRAVITY = 700.0
const SPEED = 200.0
const JUMP_SPEED = 500.0
var jump_numbers = 0
var max_jumps = 2
var velocity = Vector2()

func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	velocity.x += delta * SPEED

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
		velocity.y -= JUMP_SPEED
		jump_numbers += 1

func _ready():
	set_fixed_process(true)
	get_node("AnimationPlayer").play("Run1")
	set_process_input(true)