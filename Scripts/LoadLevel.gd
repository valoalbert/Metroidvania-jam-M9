extends Node2D

var player_scene = preload("res://Entities/Player/Player.tscn")
var HUD_scene = preload("res://Scenes/Hud.tscn")
var healthbar_scene = preload("res://Scenes/Healthbar.tscn")
var player
var HUD
var healthbar
var player_position

func _ready():
	
	#pause_mode = Node.PAUSE_MODE_PROCESS
	player = player_scene.instance()
	HUD = HUD_scene.instance()
	healthbar = healthbar_scene.instance()
	
	add_child(HUD)
	HUD.add_child(healthbar)
	healthbar.visible = false
	
	player_position = SceneSwitcher.getPlayerPosition()
	player.global_transform = get_node(player_position).get_global_transform()
	
	add_child(player)
	Game.fade_out()
	yield(get_tree().create_timer(0.3), "timeout")
	healthbar.visible = true
	#get_tree().paused = false
