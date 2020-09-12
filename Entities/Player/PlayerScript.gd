extends KinematicBody2D

# JUMP HEIGHT
const JUMP_H = -900
const UP = Vector2(0, -1)
const WALL_SLIDE_ACCELERATION = 10
const MAX_WALL_SLIDE_SPEED = 120

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
var wall_jump_skill : bool
var able_to_wall_jump : bool
var player_sprite_scale : int
var collectables : int
export var able_to_jump : bool
export var attacking : bool
#var gravity_changed : bool
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
	
	# INITIALIZE PROPERTIES
	health = SceneSwitcher.getPlayerHealth()
	double_jump_skill = SceneSwitcher.getDoubleJumpSkill()
	dash_skill = SceneSwitcher.getDashSkill()
	wall_jump_skill = SceneSwitcher.getWallJumpSkill()
	player_sprite_scale = SceneSwitcher.getPlayerSpriteScale()
	sprite.scale.x = player_sprite_scale
	collectables = SceneSwitcher.getPlayerCollectables()
	pass
	
func _physics_process(_delta):
	if health <= 0:
		is_dead = true
	
	if is_dead:
		SceneSwitcher.setDashSkill(dash_skill)
		SceneSwitcher.setDoubleJumpSkill(double_jump_skill)
		SceneSwitcher.setWallJumpSkill(wall_jump_skill)
		SceneSwitcher.setPlayerCollectables(collectables)
		
		Game.game_start = false
		healthbar.visible = false
		stateMachine.travel("die")
		yield(get_tree().create_timer(1), "timeout")
		
		Game.game_over()
		get_tree().paused = true
		pass
	else:
		if health > 100:
			health = 100
		velocity.y += gravity
		healthbar._on_health_updated(health)
		healthbar._on_collectable_updated(collectables)
		healthbar._on_skill_updated(double_jump_skill, dash_skill, wall_jump_skill)
		get_input()
		velocity = move_and_slide(velocity, UP)

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
			dash()
	pass
	
	if is_on_floor():
		able_to_jump = true
		jumping = false
		velocity.x = lerp(velocity.x, 0, 0.2)
		jumpCounter = 0
		dashCounter = 0
		
		attack()
			
		if !attacking:
			jump()
		pass
	
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
				able_to_jump = false
	pass
	
	if is_on_wall() and wall_jump_skill:
		
		if Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left"):
			stateMachine.travel("Wall")
			jumpCounter = 0
			jump()
			if velocity.y >= 0:
				velocity.y = min(velocity.y + WALL_SLIDE_ACCELERATION, MAX_WALL_SLIDE_SPEED)
			else:
				velocity.y += gravity
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
		stateMachine.travel("Run")
		dashCounter += 1
		max_speed = 2000
		acceleration = 1000
		gravity = 0
		$Timer.start()
	pass

func jump():
	if Input.is_action_just_pressed("ui_accept") and able_to_jump:
		jumping = true
		stateMachine.travel("Fall 2")
		jumpCounter += 1
		velocity.y = JUMP_H

		if is_on_wall() and wall_jump_skill: 
			$WallJumpTimer.start()
			able_to_jump = false
			if Input.is_action_pressed("ui_right"): 
				velocity.x = -base_max_speed
			elif Input.is_action_pressed("ui_left"):
				velocity.x = base_max_speed
	return

func hurt(damage):
	health -= damage
	velocity.y = -600
	pass

# TIME OUT FOR THE DASH AND GET MAX SPEED AND ACCELERATION BACK TO ORIGINAL VALUES
func _on_Timer_timeout():
	max_speed = base_max_speed
	gravity = 40.0
	acceleration = base_acceleration
	pass


func _on_WallJumpTimer_timeout():
	able_to_jump = true
	pass 
