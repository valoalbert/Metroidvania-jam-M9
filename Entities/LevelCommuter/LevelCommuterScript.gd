extends Area2D

export(String) var next_scene_name
export(String) var next_area_name

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene("res://Scenes/DebugLevels/"+next_scene_name+".tscn")
			
			print("player colliding")
	pass
