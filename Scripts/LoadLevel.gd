extends Node2D

var player_scene = preload("res://Entities/Player/Player.tscn")
var HUD_scene = preload("res://Scenes/Hud.tscn")
var healthbar_scene = preload("res://Scenes/Healthbar.tscn")
var player
var HUD
var healthbar
var player_position

func _ready():
	player = player_scene.instance()
	HUD = HUD_scene.instance()
	healthbar = healthbar_scene.instance()
	
	add_child(HUD)
	HUD.add_child(healthbar)
	
	player_position = SceneSwitcher.getPlayerPosition()
	player.global_transform = get_node(player_position).get_global_transform()
	
	add_child(player)
	
