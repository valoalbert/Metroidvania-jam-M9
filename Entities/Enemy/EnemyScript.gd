extends KinematicBody2D
 
#class_name BaseEnemy
 
export var max_speed = 150
const UP = Vector2(0, -1)
const gravity = 40
 
var velocity = Vector2.ZERO
export var reverse: bool
var sprite
var stun
var health
export var damage : int = 0
 
func _ready():
	sprite = $Sprite
	$Sprite/Hit.visible = false
	$Sprite/Hit.emitting = false
	$AnimationPlayer.play("Walk")
	velocity.x = max_speed
	health = 30
 
func _physics_process(delta):
 
	velocity.y += gravity
 
	if health == 0:
		Game.robot_explosion.playing = true
		queue_free()
 
	if is_on_wall():
		if reverse:
			velocity.x = max_speed
			reverse = false
			sprite.scale.x = 1
		else:
			velocity.x = -max_speed
			reverse = true
			sprite.scale.x = -1
 
	velocity = move_and_slide(velocity, UP)
 
 
func stun():
	Game.hit_sound.playing = true
	$Sprite/Hit.visible = true
	$AnimationPlayer.stop()
	$Sprite/Hit.emitting = true
	health -= 10
	velocity.x = 0
	$Timer.start()
 
func _on_Timer_timeout():
	$Sprite/Hit.visible = false
	$AnimationPlayer.play("Walk")
	if reverse:
		velocity.x = -max_speed
	else:
		velocity.x = max_speed
