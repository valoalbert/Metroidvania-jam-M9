extends CanvasLayer

var play_button
var quit_button

func _ready():
	play_button = $Control/PlayButton
	quit_button = $Control/QuitButton
	if !Game.game_over_bool:
		Game.menu_music.playing = true
	
func _on_PlayButton_pressed():
	# START GAME
	SceneSwitcher.setPlayerHealth(100)
	Game.game_start = true
	Game.menu_music.stop()
	Game.game_over_music.stop()
	SceneSwitcher.setPlayerPosition("West")
	Game.fade_in_splash()
	yield(get_tree().create_timer(0.5), "timeout")
	Game.main_theme.playing = true
	get_tree().change_scene("res://Scenes/Inputs.tscn")
	
	
	if get_parent().has_node("GameOver"):
		get_parent().get_node("/root/GameOver").queue_free()
	queue_free()
	pass

func _on_QuitButton_pressed():
	get_tree().quit()
	pass 

func _on_PlayButton_mouse_entered():
	$Control/PlayButton.modulate = "#ec80ff"
	pass

func _on_PlayButton_mouse_exited():
	$Control/PlayButton.modulate = "#ffffff"

func _on_QuitButton_mouse_entered():
	quit_button.modulate = "#ec80ff"

func _on_QuitButton_mouse_exited():
	quit_button.modulate = "#ffffff"
