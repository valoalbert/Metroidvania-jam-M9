extends CanvasLayer

var play_button
var quit_button

func _ready():
	play_button = $Control/PlayButton
	quit_button = $Control/QuitButton

func _on_PlayButton_pressed():
	# START GAME
	SceneSwitcher.setPlayerPosition("West")
	Game.fade_in()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://Scenes/Levels/Stage0_1.tscn")
	
	if get_parent().has_node("GameOver"):
		get_parent().get_node("/root/GameOver").queue_free()
	queue_free()
	pass

func _on_QuitButton_pressed():
	get_tree().quit()
	pass 

func _on_PlayButton_mouse_entered():
	#play_button.icon = load("res://icon.png")
	pass


func _on_PlayButton_mouse_exited():
	play_button.icon = load("res://Assets/Menu_assets/new_game_button.png")
