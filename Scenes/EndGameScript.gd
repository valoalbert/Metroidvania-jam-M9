extends Control



func _on_Button_pressed():
	SceneSwitcher.init_game()
	
	Game.game_start = true
	Game.menu_music.stop()
	Game.game_over_music.stop()
	SceneSwitcher.setPlayerPosition("West")
	Game.fade_in()
	yield(get_tree().create_timer(0.5), "timeout")
	Game.main_theme.playing = true
	get_tree().change_scene("res://Scenes/Levels/Stage1_1.tscn")
	
	
	if get_parent().has_node("GameOver"):
		get_parent().get_node("/root/GameOver").queue_free()
	queue_free()
	pass # Replace with function body.


func _on_Button_mouse_entered():
	$Button.icon = load("res://Assets/Menu_assets/new_game_button_active.png")
	pass # Replace with function body.


func _on_Button_mouse_exited():
	$Button.icon = load("res://Assets/Menu_assets/new_game_button.png")
	pass # Replace with function body.
