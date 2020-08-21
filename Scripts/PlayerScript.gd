extends KinematicBody2D

# JUMP HEIGHT
const JUMP_H = -900
const UP = Vector2(0, -1)
const GRAVITY = 40

export onready var acceleration
export onready var max_speed
var sprite
var animationPlayer
var jumpCounter
var friction
var stateMachine
var velocity

func _ready():
	# IN CASE YOU NEED TO MODIFY ANY VALUE, HERE IS THE PLACE
	acceleration = 80
	max_speed = 400
	# COUNTER FOR THE DOUBLE JUMP
	jumpCounter = 0
	velocity = Vector2.ZERO
	
	sprite = $Sprite
	animationPlayer = $AnimationPlayer
	stateMachine = $AnimationTree.get("parameters/playback")
	
	stateMachine.start("Idle")
	
	pass
	
func _physics_process(delta):
	velocity.y += GRAVITY
	get_input(friction)
	dash()
	velocity = move_and_slide(velocity, UP)

	pass

# FUNCTION TO GET PLAYER CONTROL
func get_input(friction):
	if Input.is_action_pressed("ui_right"):
		stateMachine.travel("Walk")
		sprite.flip_h = false
		velocity.x = min(velocity.x + acceleration, max_speed)
	elif Input.is_action_pressed("ui_left"):
		stateMachine.travel("Walk")
		sprite.flip_h = true
		velocity.x = max(velocity.x - acceleration, -max_speed)
	else:
		stateMachine.travel("Idle")
		friction = true
	
	if is_on_floor():
		jumpCounter = 0
		if Input.is_action_just_pressed("action"):
			stateMachine.travel("Attack")
		
		if friction == true:
			velocity.x = lerp(velocity.x, 0, 0.5)
		
		if Input.is_action_just_pressed("ui_accept"):
			jumpCounter += 1
			velocity.y = JUMP_H
		if friction == true:
			velocity.x = lerp(velocity.x, 0, 0.01)
	else:
		stateMachine.travel("Jump")
		if jumpCounter < 2 and Input.is_action_just_pressed("ui_accept"):
			jumpCounter += 1 
			velocity.y = JUMP_H
	
	pass

# DASH FUNCTION, MODIFIES ORIGINAL PLAYER MAX SPEED AND ACCELERATION
func dash():
	if Input.is_action_just_pressed("dash"):
		max_speed = 2000
		acceleration = 1000
		$Timer.start()
	pass

# TIME OUT FOR THE DASH AND GET MAX SPEED AND ACCELERATION BACK TO ORIGINAL VALUES
func _on_Timer_timeout():
	max_speed = 300
	acceleration = 70
	
	pass
