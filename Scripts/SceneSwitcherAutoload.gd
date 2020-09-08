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

func _ready():
	setPlayerHealth(100)
	setDashSkill(false)
	setDoubleJumpSkill(false)
	pass

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
