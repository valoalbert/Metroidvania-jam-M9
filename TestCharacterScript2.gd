extends KinematicBody2D

# Properties for smooth movement initiation and stoping
const ACCELERATION = 70
const MAX_SPEED = 300
const JUMP_H = -900
const UP = Vector2(0, -1)
const GRAVITY = 40

var sprite
var animationPlayer
var jumpCounter
var friction
var stateMachine
# Character velocity
var motion = Vector2()


func _ready():
	sprite = $Sprite
	animationPlayer = $AnimationPlayer
	stateMachine = $AnimationTree.get("parameters/playback")
	stateMachine.start("Idle")
	jumpCounter = 0
	

func _physics_process(delta):
	#TODO refactor code
	motion.y += GRAVITY
	friction = false
	
	get_input(friction)
	
	motion = move_and_slide(motion, UP)
	pass

func get_input(friction):
	
	
	if Input.is_action_pressed("ui_right"):
		stateMachine.travel("Run")
		sprite.flip_h = false
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		stateMachine.travel("Run")
		sprite.flip_h = true
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	else:
		
		friction = true
		
	if is_on_floor():
		stateMachine.travel("Idle")
		jumpCounter = 0	
													 
		if Input.is_action_just_pressed("ui_accept"):
			jumpCounter += 1
			motion.y = JUMP_H
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.01)
		
		if jumpCounter < 2 and Input.is_action_just_pressed("ui_accept"):
			jumpCounter += 1 
			stateMachine.travel("Jump")
			motion.y = JUMP_H
