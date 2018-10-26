extends KinematicBody2D

var speed = 200
var velocity = Vector2(0, 10)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	velocity.x += delta * speed
	velocity.y += delta * speed
	move_and_slide(velocity)