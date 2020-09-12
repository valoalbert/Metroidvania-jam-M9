extends Control

onready var health_bar = $Healthbar
onready var text = $Collectable

func _on_health_updated(health):
	health_bar.value = health
	
func _on_max_health_updated(max_health):
	health_bar.max_value = max_health

func _on_collectable_updated(collectable):
	text.bbcode_text = str(collectable)+"/10"
	pass
	
