extends Node2D

var player_scene = preload("res://Entities/Player/Player.tscn")
var HUD_scene = preload("res://Scenes/Hud.tscn")
var healthbar_scene = preload("res://Scenes/Healthbar.tscn")
var player
var HUD
var healthbar
var player_position

func _ready():
	#get_parent().add_child(player)
	HUD = HUD_scene.instance()
	healthbar = healthbar_scene.instance()
	add_child(HUD)
	HUD.add_child(healthbar)
	
	player = player_scene.instance()
	player_position = $Position2D
	player.global_transform = player_position.get_global_transform()
	
	add_child(player)
