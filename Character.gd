extends KinematicBody2D

var new_member_class = preload("res://NewMember.tscn")

const IDLE_TIME_AT_START = 1 #sec
const GRAVITY = 2500.0
const SPEED = 250.0
const INITIAL_JUMP = 500.0
const MAX_JUMP = 850.0
const JUMP_INCREMENT = 300.0
const MAX_SPEED = 850.0
const rads_per_sec = 3
var jump_numbers = 0
var max_jumps = 2
var velocity = Vector2()

var is_jumping = false

var rads = 0.0

var possible_mutations
var taken_mutations = []
var mutation_level = 0

var ready = false

func _process(delta):
	if not ready:
		return
	affect_rads(delta*rads_per_sec)

func _fixed_process(delta):
	if not ready:
		return

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
		if motion.y < 0.1:
			if jump_numbers > 0:
				get_node("AnimationPlayer").play("Run1")
			jump_numbers = 0

func _input(event):
	if not ready:
		return
	
	if event.is_action_pressed("jump") and jump_numbers < max_jumps:
		get_node("AnimationPlayer").play("Jump")
		velocity.y -= INITIAL_JUMP
		jump_numbers += 1
		is_jumping = true
	if event.is_action_released("jump") and is_jumping:
		is_jumping = false
		velocity.y += INITIAL_JUMP / 1.5

func _ready():
	get_node("AnimationPlayer").play("Idle_before")
	var t = Timer.new()
	t.set_wait_time(IDLE_TIME_AT_START)
	add_child(t)
	t.set_one_shot(true)
	t.connect("timeout", self, "start")
	t.start()
	set_fixed_process(true)
	set_process(true)
	set_process_input(true)
	possible_mutations = [
		get_node("Mut1"),
		get_node("Mut2"),
		get_node("Mut3"),
		get_node("Mut4"),
		get_node("Mut5"),
		get_node("Mut6"),
		get_node("Mut7"),
		get_node("Mut8"),
		get_node("Mut9"),
		get_node("Mut10")
	]

func start():
	ready = true
	get_node("AnimationPlayer").play("Run1")

func stop():
	ready = false
	velocity.x = 0
	get_node("AnimationPlayer").play("Idle_before")
	get_parent().end(rads)

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
	
	if value > 0:
		var number_of_mutations = int(rads) / 10 - mutation_level
		for i in range(number_of_mutations):
			pop_mutation()
	if value < 0:
		var number_of_mutations = mutation_level - int(rads) / 10
		for i in range(number_of_mutations):
			depop_mutation()

func pop_mutation():
	if possible_mutations.size() > 0:
		mutation_level += 1
		randomize()
		var idx = randi() % possible_mutations.size()
		var mutation = possible_mutations[idx]
		possible_mutations.remove(idx)
		taken_mutations.append(mutation)
		mutation.activate()

func depop_mutation():
	if taken_mutations.size() > 0:
		randomize()
		mutation_level -= 1
		var idx = randi() % taken_mutations.size()
		var mutation = taken_mutations[idx]
		taken_mutations.remove(idx)
		possible_mutations.append(mutation)
		mutation.deactivate()