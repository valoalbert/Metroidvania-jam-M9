extends Area2D

export var id : int = 0

func _ready():
	$AnimationPlayer.play("collectable")
	if SceneSwitcher.coll_array.has(id):
		queue_free()

func _on_Collectable_body_entered(body):
	if body.is_in_group("Player"):
		SceneSwitcher.coll_array.push_front(id)
		if SceneSwitcher.coll_array.size() == 16:
			Game.game_start = false
			body.healthbar.visible = false
			Game.end_game()
			print("endgame")
		else:
			body.collectables += 1
			pass
		
		Game.skill_sound.playing = true
		queue_free()
		pass
