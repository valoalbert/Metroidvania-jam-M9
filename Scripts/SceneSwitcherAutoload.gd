extends Node

# PROPERTIES TO CARRY OVER SCENES
# 1. PLAYER HEALTH AND SKILLS 
# 2. LEVEL NAME
# 3. PLAYER POSITION

var player_health : int setget setPlayerHealth, getPlayerHealth
var level_name : String setget setLevelName, getLevelName
var player_position : String setget setPlayerPosition, getPlayerPosition
var dash_skill : bool setget setDashSkill, getDashSkill
var double_jump_skill : bool setget setDoubleJumpSkill, getDoubleJumpSkill
var wall_jump_skill : bool setget setWallJumpSkill, getWallJumpSkill
var player_sprite_scale : int setget setPlayerSpriteScale, getPlayerSpriteScale
var player_collectables : int setget setPlayerCollectables, getPlayerCollectables
var coll_array : Array

func _ready():
	init_game()
	pass
	
func init_game():
	setPlayerHealth(100)
	setDashSkill(false)
	setDoubleJumpSkill(false)
	setWallJumpSkill(false)
	setPlayerSpriteScale(1)
	setPlayerPosition("initial")
	setPlayerCollectables(0)
	coll_array.clear()

func setPlayerHealth(health):
	player_health = health
	
func getPlayerHealth():
	return player_health

func setLevelName(name):
	level_name = name
	
func getLevelName():
	return level_name
	
func setPlayerPosition(position):
	player_position = position

func getPlayerPosition():
	return player_position

func setDashSkill(dash_skill_arg):
	dash_skill = dash_skill_arg

func getDashSkill():
	return dash_skill
	
func setDoubleJumpSkill(double_jump_skill_arg):
	double_jump_skill = double_jump_skill_arg
	
func getDoubleJumpSkill():
	return double_jump_skill

func setWallJumpSkill(wall_jump_skill_arg):
	wall_jump_skill = wall_jump_skill_arg

func getWallJumpSkill():
	return wall_jump_skill

func setPlayerSpriteScale(player_sprite_scale_arg):
	player_sprite_scale = player_sprite_scale_arg

func getPlayerSpriteScale():
	return player_sprite_scale

func setPlayerCollectables(player_collectables_arg):
	player_collectables = player_collectables_arg
	
func getPlayerCollectables():
	return player_collectables
