extends Area2D

var bodies
var damage
# Called when the node enters the scene tree for the first time.
func _ready():

	pass

func _process(_delta):
	
	bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Enemy"):
			damage = 10
			get_parent().hurt(damage)
			$CollisionShape2D.disabled = true
			$Timer.start()
			get_parent()
		pass



func _on_Timer_timeout():
	get_parent().hurt = false
	get_parent().sprite.modulate = "#ffffffff" 
	$CollisionShape2D.disabled = false

