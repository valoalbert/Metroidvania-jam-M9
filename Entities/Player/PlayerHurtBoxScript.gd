extends Area2D

var bodies

# Called when the node enters the scene tree for the first time.
func _ready():

	pass

func _process(_delta):
	
	bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Enemy"):
			get_parent().hurt()
			$CollisionShape2D.disabled = true
			$Timer.start()
		pass



func _on_Timer_timeout():
	get_parent().hurt = false
	get_parent().sprite.modulate = "#ffffffff" 
	$CollisionShape2D.disabled = false

