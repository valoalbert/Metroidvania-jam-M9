extends KinematicBody2D

#class_name BaseEnemy

const ACCELERATION = 90
export var max_speed = 500
const UP = Vector2(0, -1)
const gravity = 40

var velocity = Vector2.ZERO
export var reverse: bool
var sprite

func _ready():
	sprite = $Sprite
	velocity.x = min(velocity.x + ACCELERATION, max_speed)
	pass

func _physics_process(delta):
	
	velocity.y += gravity
	
	if is_on_wall():
		if reverse:
			velocity.x = max(velocity.x - ACCELERATION, -max_speed)
			reverse = false
			sprite.flip_h = true
		else:
			velocity.x = min(velocity.x + ACCELERATION, max_speed)
			reverse = true
			sprite.flip_h = false
		
	
	velocity = move_and_slide(velocity, UP)
