extends KinematicBody2D

# Properties for smooth movement initiation and stoping
#const ACCELERATION = 70
#const MAX_SPEED = 300
#const JUMP_H = -900
const UP = Vector2(0, -1)
#const gravity = 40

export var ACCELERATION = 70
export var MAX_SPEED = 300
export var JUMP_H = -900
export var gravity = 40

var sprite
var animationPlayer
var jumpCounter
var isAttacking
# Character velocity
var motion = Vector2()

func _ready():
	sprite = $Sprite
	animationPlayer = $AnimationPlayer
	jumpCounter = 0
	isAttacking = false

func _physics_process(delta):
	#TODO refactor code
	
	# apply gravity to the player
	motion.y += gravity
	var friction = false
	print(str(jumpCounter)+"\n"+str(motion.y))
	
	PlayerControl(friction)
		
	motion = move_and_slide(motion, UP)
	pass

func PlayerControl(friction):
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = false
		animationPlayer.play("Run")
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		animationPlayer.play("Run")
		sprite.flip_h = true
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	elif Input.is_action_just_pressed("action"):
		animationPlayer.play("Attack")
		yield(get_node("AnimationPlayer"), "animation_finished")
	else:
		animationPlayer.play("Idle")
		friction = true
	
	if is_on_floor():
		jumpCounter = 0
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = JUMP_H
			jumpCounter += 1
			
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
	else:
		animationPlayer.play("Jump")
		
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
		if jumpCounter < 2 and Input.is_action_just_pressed("ui_accept"):
			jumpCounter += 1
			motion.y = JUMP_H

