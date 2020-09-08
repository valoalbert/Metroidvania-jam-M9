extends Area2D

export (PackedScene) var next_level
export (String) var player_position
var player_health : int

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			load_level(player_position, body.health)
			
			
			print("player colliding")
	pass

func load_level(player_position, player_health):
	SceneSwitcher.setPlayerHealth(player_health)
	SceneSwitcher.setPlayerPosition(player_position)
	
	get_tree().change_scene_to(next_level)
