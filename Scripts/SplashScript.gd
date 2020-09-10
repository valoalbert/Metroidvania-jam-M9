extends Node2D

func _ready():
	Game.fade_out_splash()
	yield(get_tree().create_timer(3), "timeout")
	Game.fade_in_splash()
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://Scenes/Menu.tscn")
