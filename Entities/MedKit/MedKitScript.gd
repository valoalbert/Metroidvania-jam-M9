extends Area2D

export var ammount : int
var sprite

func _ready():
	sprite = $Sprite
	$AnimationPlayer.play("Medkit")
	pass

func _on_MedKit_body_entered(body):
	if body.is_in_group("Player"):
		if body.health < 100:
			Game.medkit_sound.playing = true
			body.health += ammount
			queue_free()
	pass # Replace with function body.
