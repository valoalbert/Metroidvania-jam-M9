extends KinematicBody2D

# JUMP HEIGHT
const JUMP_H = -900
const UP = Vector2(0, -1)
var GRAVITY = 40.0

var acceleration
var max_speed
var sprite
var animationPlayer
var jumpCounter
var dashCounter
var friction
var stateMachine
var velocity
var base_acceleration
var base_max_speed
var jumping

var is_dead : bool
export var ready_to_jump: bool

func _ready():
	# IN CASE YOU NEED TO MODIFY ANY VALUE, HERE IS THE PLACE
	base_acceleration = 90
	base_max_speed = 500
	
	acceleration = base_acceleration
	max_speed = base_max_speed
	
	# COUNTER FOR THE DOUBLE JUMP
	jumpCounter = 0
	dashCounter = 0
	velocity = Vector2.ZERO
	
	sprite = $Sprite
	#animationPlayer = $AnimationPlayer
	stateMachine = $AnimationTree.get("parameters/playback")
	
	stateMachine.start("Idle")
	jumping = false
	ready_to_jump = true
	is_dead = false
	pass
	
func _process(delta):
	
	velocity.y += GRAVITY
	get_input(friction)
	dash()
	velocity = move_and_slide(velocity, UP)

	pass

# FUNCTION TO GET PLAYER CONTROL
func get_input(friction):
	if Input.is_action_pressed("ui_right"):
		if !jumping:
			stateMachine.travel("Run")
		sprite.flip_h = false
		velocity.x = min(velocity.x + acceleration, max_speed)
	elif Input.is_action_pressed("ui_left"):
		if !jumping:
			stateMachine.travel("Run")
		sprite.flip_h = true
		velocity.x = max(velocity.x - acceleration, -max_speed)
	else:
		if !jumping:
			stateMachine.travel("Idle")
		friction = true
	
	if is_on_floor():
		jumping = false
		ready_to_jump = true
		
		jumpCounter = 0
		dashCounter = 0
		if Input.is_action_just_pressed("action"):
			stateMachine.travel("Attack")
			print("attack")
			pass
		
		if friction == true:
			velocity.x = lerp(velocity.x, 0, 0.5)
		
		if Input.is_action_just_pressed("ui_accept"):
			jumping = true
			ready_to_jump = false
			
			stateMachine.travel("Jump")
			jumpCounter += 1
			velocity.y = JUMP_H
		if friction == true:
			velocity.x = lerp(velocity.x, 0, 0.01)
	else:
		print("is not on floor")
		
		if jumping == false:
			stateMachine.travel("Fall 2")

		else:
			if jumpCounter < 2 and ready_to_jump and Input.is_action_just_pressed("ui_accept"):
				ready_to_jump = false
				stateMachine.travel("Jump")
				jumpCounter += 1 
				velocity.y = JUMP_H	
	pass

# DASH FUNCTION, MODIFIES ORIGINAL PLAYER MAX SPEED AND ACCELERATION
func dash():
	if  Input.is_action_just_pressed("dash") && dashCounter < 1:
		dashCounter += 1
		max_speed = 2000
		acceleration = 1000
		GRAVITY = 0
		$Timer.start()
	pass

# TIME OUT FOR THE DASH AND GET MAX SPEED AND ACCELERATION BACK TO ORIGINAL VALUES
func _on_Timer_timeout():
	max_speed = base_max_speed
	GRAVITY = 40.0
	acceleration = base_acceleration
	pass
