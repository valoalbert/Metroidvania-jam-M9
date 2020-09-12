extends Node2D

func _ready():
	Game.game_start = false
	get_parent().move_child(self, 1)
	Game.fade_out_splash()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Game.game_start = true
		Game.fade_in_splash()
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().change_scene("res://Scenes/Levels/Stage1_1.tscn")
