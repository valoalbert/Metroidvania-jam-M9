extends Node2D

var player_scene = preload("res://Entities/Player/Player.tscn")
var player
var player_position

func _ready():
	#get_parent().add_child(player)
	player = player_scene.instance()
	player_position = $Position2D
	player.global_transform = player_position.get_global_transform()
	
	add_child(player)
