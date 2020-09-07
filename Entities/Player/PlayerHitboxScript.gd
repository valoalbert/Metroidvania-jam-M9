extends Area2D

var bodies

# Called when the node enters the scene tree for the first time.
func _ready():

	pass

func _process(_delta):

	bodies = get_overlapping_bodies()
	
	for body in bodies:
		$CollisionShape2D.disabled = true
		if body.is_in_group("Enemy"):
			body.stun()
			print("hit to enemy")

		pass
