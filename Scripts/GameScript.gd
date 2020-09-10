extends Node2D

var fade
var fade_tween
var game_over_scene = preload("res://Scenes/GameOver.tscn")
var game_over_menu

func _ready():
	fade = $HUD/Fade
	fade_tween = $HUD/Fade/Tween
	#game_over_menu = game_over_scene.instance()
	pass

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
	if !get_parent().has_node("GameOver"):
		game_over_menu = game_over_scene.instance()
	get_parent().move_child(self, 3)
	fade_tween.interpolate_property(fade, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 0.8), 1, 
	  Tween.TRANS_LINEAR, Tween.EASE_IN)
	fade_tween.start()
	yield(get_tree().create_timer(0.8), "timeout")
	get_parent().add_child(game_over_menu)
	
	pass
