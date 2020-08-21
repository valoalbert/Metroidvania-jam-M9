extends Area2D

export var levelId = ""

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "PlayerKinematic":
			#get_tree().change_scene("res://scenes/Levels/"+levelId+".tscn")
			get_tree().change_scene("res://Scenes/"+levelId+".tscn")
			print("player colliding")
