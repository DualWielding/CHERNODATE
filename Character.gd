extends KinematicBody2D

var speed = 200
var max_speed = 1000
var velocity = Vector2(0, 10)

func _ready():
	set_fixed_process(true)
	get_node("AnimationPlayer").play("Run1")

func _fixed_process(delta):
	if velocity.x < max_speed:
		velocity.x += delta * speed
	velocity.y += delta * speed
	move_and_slide(velocity)