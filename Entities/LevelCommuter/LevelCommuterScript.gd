extends Area2D

export (String) var next_level_name
export (String) var player_position
var player_health : int

var next_level

func _ready():

	next_level = "res://Scenes/DebugLevels/"+next_level_name+".tscn"
func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			load_level(player_position, body.health)
	pass

func load_level(player_position, player_health):
	SceneSwitcher.setPlayerHealth(player_health)
	SceneSwitcher.setPlayerPosition(player_position)
	get_tree().change_scene(next_level)
