extends Node2D

var player_scene = preload("res://Entities/Player/Player.tscn")
var player
var player_position

func _ready():
	player = player_scene.instance()
	player_position = SceneSwitcher.getPlayerPosition()
	#player_position = get_node(SceneSwitcher.getPlayerPosition())
	player.global_transform = get_node(player_position).get_global_transform()
	
	add_child(player)
	
	player.health = SceneSwitcher.getPlayerHealth()
