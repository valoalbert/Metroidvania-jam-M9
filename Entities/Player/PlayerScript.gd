extends KinematicBody2D

# JUMP HEIGHT
const JUMP_H = -900
const UP = Vector2(0, -1)

var gravity = 40.0
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

export var able_to_jump : bool
export var attacking : bool

func _ready():
	# IN CASE YOU NEED TO MODIFY ANY VALUE, HERE IS THE PLACE
	base_acceleration = 100
	base_max_speed = 550
	
	acceleration = base_acceleration
	max_speed = base_max_speed
	
	# COUNTER FOR THE DOUBLE JUMP
	jumpCounter = 0
	dashCounter = 0

	sprite = $Sprite
	stateMachine = $AnimationTree.get("parameters/playback")
	stateMachine.start("Idle")
	velocity = Vector2.ZERO
	
	jumping = false
	is_dead = false
	attacking = false
	pass
	
func _process(_delta):
	
	# DEBUG OPTIONS
	
	# if Input.is_action_pressed("is_dead"):
	# 	stateMachine.travel("die")
	# 	print("You killed the player")
	# 	is_dead = true
	# pass
	# print(jumpCounter," ", able_to_jump)
	#print(stateMachine.get_current_node())
	#print("attacking: ", attacking)
	
	### END DEBUG OPTIONS
	
	
	velocity.y += gravity
	get_input()
	dash()
	velocity = move_and_slide(velocity, UP)
	if is_dead:
		set_process(false)
	pass

# FUNCTION TO GET PLAYER CONTROL
func get_input():
	# MOVEMENT
	stateMachine.travel("Idle")
		
	if attacking == false:
		if Input.is_action_pressed("ui_right"):
			stateMachine.travel("Run")
			sprite.scale.x = 1
			velocity.x = max_speed
		elif Input.is_action_pressed("ui_left"):
			stateMachine.travel("Run")
			sprite.scale.x = -1
			velocity.x = -max_speed
		
		# DASH INPUT
		if Input.is_action_just_pressed("dash"):
			stateMachine.travel("Run")
			dash()
	pass

	if is_on_floor():
		print("is on floor")
		jumping = false
		velocity.x = lerp(velocity.x, 0, 0.2)
		jumpCounter = 0
		dashCounter = 0
		able_to_jump = false
		
		attack()
			
		if !attacking:
			if Input.is_action_just_pressed("ui_accept"):
				jumping = true
				stateMachine.travel("Fall 2")
				jumpCounter += 1
				velocity.y = JUMP_H
	
	# PLAYER IS IN THE AIR (IS JUMPING)
	else:
		print("is not on floor")
		velocity.x = lerp(velocity.x, 0, 0.03)

		if jumping == false:
			stateMachine.travel("Fall")
		else:
			stateMachine.travel("Fall 2")
			if jumpCounter < 2 and able_to_jump and Input.is_action_just_pressed("ui_accept"):
				stateMachine.travel("Jump 2")
				jumpCounter += 1 
				velocity.y = JUMP_H
	pass

# COMBAT SYSTEM
func attack():
	if Input.is_action_just_pressed("action") and !attacking:
		if stateMachine.get_current_node() == "Attack_1":
			stateMachine.travel("Attack_2")
			print("attack 2")
		elif stateMachine.get_current_node() == "Attack_2":
			stateMachine.travel("Attack_3")
			print("attack 3")
		else:
			stateMachine.travel("Attack_1")
			print("attack 1")
		
	pass

# DASH FUNCTION, MODIFIES ORIGINAL PLAYER MAX SPEED AND ACCELERATION
func dash():
	if  Input.is_action_just_pressed("dash") and dashCounter < 1:
		dashCounter += 1
		max_speed = 2000
		acceleration = 1000
		gravity = 0
		$Timer.start()
	pass

# TIME OUT FOR THE DASH AND GET MAX SPEED AND ACCELERATION BACK TO ORIGINAL VALUES
func _on_Timer_timeout():
	max_speed = base_max_speed
	gravity = 40.0
	acceleration = base_acceleration
	pass
