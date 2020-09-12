extends KinematicBody2D
 
#class_name BaseEnemy
 
var sprite
var stun
var health
export var damage : int = 0
 
func _ready():
	sprite = $Sprite
	$Sprite/Hit.visible = false
	$Sprite/Hit.emitting = false
	$AnimationPlayer.play("Walk")
	health = 20
 
 
 
 
func stun():
	$Sprite/Hit.visible = true
	$Sprite/Hit.emitting = true
	$Timer.start()
 
func _on_Timer_timeout():
	$Sprite/Hit.visible = false
	$AnimationPlayer.play("Walk")
