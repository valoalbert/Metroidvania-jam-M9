extends Node2D

var fade
var fade_tween
var game_over_scene = preload("res://Scenes/GameOver.tscn")
var end_game_scene = preload("res://Scenes/EndGame_final.tscn")
var game_over_menu
var end_game_screen
var menu_music
var main_theme
var game_over_music
var game_over_bool
var hit_sound
var robot_explosion
var skill_sound
var pause_sound
var game_paused : bool
var game_start : bool

func _ready():
	game_start = false
	game_paused = false
	fade = $HUD/Fade
	fade_tween = $HUD/Fade/Tween
	menu_music = $MenuMusic
	main_theme = $main_theme
	game_over_music = $game_over
	hit_sound = $hit
	robot_explosion = $explosion
	skill_sound = $Skill
	pause_sound = $Pause
	pass
	
func _physics_process(_delta):
	if game_start:
		if Input.is_action_just_pressed("pause"):
			pause_sound.playing = true
			game_paused = true
			if get_tree().paused == true:
				get_tree().paused = false
			else:
				get_tree().paused = true

func fade_in():
	
	fade_tween.interpolate_property(fade, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5, 
	  Tween.TRANS_LINEAR, Tween.EASE_IN)
	fade_tween.start()
	get_tree().paused = true
	pass
	
func fade_out():
	fade_tween.interpolate_property(fade, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5, 
	  Tween.TRANS_LINEAR, Tween.EASE_IN)
	fade_tween.start()
	get_tree().paused = false
	pass

func fade_out_splash():
	fade_tween.interpolate_property(fade, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.5, 
	  Tween.TRANS_LINEAR, Tween.EASE_IN)
	fade_tween.start()
	get_tree().paused = false
	pass
	
func fade_in_splash():
	
	fade_tween.interpolate_property(fade, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5, 
	  Tween.TRANS_LINEAR, Tween.EASE_IN)
	fade_tween.start()
	get_tree().paused = false
	pass

func game_over():
	game_over_bool = true
	game_over_music.playing = true
	if !get_parent().has_node("GameOver"):
		game_over_menu = game_over_scene.instance()
	get_parent().move_child(self, 3)
	fade_tween.interpolate_property(fade, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 0.8), 1, 
	  Tween.TRANS_LINEAR, Tween.EASE_IN)
	fade_tween.start()
	
	yield(get_tree().create_timer(0.8), "timeout")
	if !get_parent().has_node("GameOver"):
		get_parent().add_child(game_over_menu)
	main_theme.stop()
	menu_music.stop()
	pass

func end_game():
	get_tree().paused = true
	if !get_parent().has_node("EndGame"):
		end_game_screen = end_game_scene.instance()
	
	fade_tween.interpolate_property(fade, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 0.9), 1, 
	  Tween.TRANS_LINEAR, Tween.EASE_IN)
	fade_tween.start()
	yield(get_tree().create_timer(0.8), "timeout")
	if !get_parent().has_node("EndGame"):
		get_parent().add_child(end_game_screen)
		get_parent().move_child(self, 4)
	main_theme.stop()
	print("endgame")
