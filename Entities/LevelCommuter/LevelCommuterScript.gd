extends Area2D

export (String) var next_level_name
export (String) var player_position
export var debug_level : bool
var player_health : int

var next_level

func _ready():
	if debug_level:
		next_level = "res://Scenes/DebugLevels/"+next_level_name+".tscn"
	else:
		next_level = "res://Scenes/Levels/"+next_level_name+".tscn"
		
func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			load_level(player_position, body.health, body.double_jump_skill, body.dash_skill, body.wall_jump_skill, body.sprite.scale.x)
	pass

func load_level(player_position, player_health, double_jump_skill, dash_skill, wall_jump_skill, player_sprite_scale):
	
	
	SceneSwitcher.setPlayerHealth(player_health)
	SceneSwitcher.setPlayerPosition(player_position)
	SceneSwitcher.setDoubleJumpSkill(double_jump_skill)
	SceneSwitcher.setDashSkill(dash_skill)
	SceneSwitcher.setWallJumpSkill(wall_jump_skill)
	SceneSwitcher.setPlayerSpriteScale(player_sprite_scale)
	
	Game.fade_in()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene(next_level)
