extends Node

# PROPERTIES TO CARRY OVER SCENES
# 1. PLAYER HEALTH AND SKILLS 
# 2. LEVEL NAME
# 3. PLAYER POSITION

var player_health : int setget setPlayerHealth, getPlayerHealth
var level_name : String setget setLevelName, getLevelName
var player_position : String setget setPlayerPosition, getPlayerPosition


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
