extends KinematicBody2D

# JUMP HEIGHT
const JUMP_H = -900
const UP = Vector2(0, -1)

var gravity
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
var health : int

var is_dead : bool
var hurtback : Vector2
var double_jump_skill : bool
var dash_skill : bool

export var able_to_jump : bool
export var attacking : bool
var gravity_changed : bool
var healthbar

func _ready():
	scale = Vector2(3,3)
	gravity = 40.0
	healthbar = get_parent().get_node("Hud/Healthbar")
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
	health = 100
	
	double_jump_skill = false
	dash_skill = false
	pass
	
func _process(_delta):
	if health == 0:
		print("dead")
	else:
		healthbar._on_health_updated(health)
		
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
		
		
		
		get_input()
		
		if gravity_changed:
			velocity.y -= gravity
		else:
			velocity.y += gravity
			
		velocity = move_and_slide(velocity, UP)
		
		if is_dead:
			set_process(false)
	pass

# FUNCTION TO GET PLAYER CONTROL
func get_input():
	# MOVEMENT
	stateMachine.travel("Idle")
	
	
	if !attacking:
		if Input.is_action_pressed("ui_right"):
			hurtback = Vector2(-400, -400)
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
			
		if Input.is_action_just_pressed("magnetic_boots"):
			change_gravity()
	pass
	

	if is_on_floor():
		jumping = false
		velocity.x = lerp(velocity.x, 0, 0.2)
		jumpCounter = 0
		dashCounter = 0
		
		attack()
			
		if !attacking:
			if Input.is_action_just_pressed("ui_accept"):
				jumping = true
				stateMachine.travel("Fall 2")
				jumpCounter += 1
				velocity.y = JUMP_H
	
	# PLAYER IS IN THE AIR (IS JUMPING)
	else:
		velocity.x = lerp(velocity.x, 0, 0.03)

		if jumping == false:
			stateMachine.travel("Fall")
		else:
			stateMachine.travel("Fall 2")
			if jumpCounter < 2 and double_jump_skill and Input.is_action_just_pressed("ui_accept"):
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
	if  Input.is_action_just_pressed("dash") and dashCounter < 1 and dash_skill:
		dashCounter += 1
		max_speed = 2000
		acceleration = 1000
		gravity = 0
		$Timer.start()
	pass

func change_gravity():
	gravity_changed = true
	$Timer.start()
	pass

func hurt(damage):
	health -= damage
	sprite.modulate = "#33ffffff"
	velocity.y = -600
	pass

# TIME OUT FOR THE DASH AND GET MAX SPEED AND ACCELERATION BACK TO ORIGINAL VALUES
func _on_Timer_timeout():
	max_speed = base_max_speed
	gravity = 40.0
	acceleration = base_acceleration
	pass
