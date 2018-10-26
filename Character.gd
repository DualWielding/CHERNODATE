extends KinematicBody2D

var jump_speed_decrease = 12000
var max_jump_speed = 50000
var current_jump_speed = 0
var speed = 200
var gravity = 1500
var max_speed = 1000
var velocity = Vector2(0, 10)
var can_jump = false
var is_jumping = false

func _ready():
	set_fixed_process(true)
	get_node("AnimationPlayer").play("Run1")

func _fixed_process(delta):
	print(velocity.y)
	# Y
	if Input.is_action_pressed("jump") and (can_jump or is_jumping):
		if can_jump:
			velocity.y -= current_jump_speed * delta
			can_jump = false
			is_jumping = true
		if is_jumping:
			current_jump_speed -= jump_speed_decrease
	
	if not is_move_and_slide_on_wall():# collide bot
		velocity.y += delta * gravity
	else:
		velocity.y = 0
		can_jump = true
		is_jumping = false
		current_jump_speed = max_jump_speed
	
	# X
	if velocity.x < max_speed:
		velocity.x += delta * speed
	move_and_slide(velocity)