extends Area2D

var bodies

# Called when the node enters the scene tree for the first time.
func _ready():

	pass

func _process(_delta):

	bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Enemy"):
			print("hit to enemy")

		pass