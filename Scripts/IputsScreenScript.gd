extends CanvasLayer

func _ready():
	get_parent().move_child(self, 1)
	Game.fade_out_splash()

func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		Game.fade_in_splash()
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().change_scene("res://Scenes/Levels/Stage1_1.tscn")
