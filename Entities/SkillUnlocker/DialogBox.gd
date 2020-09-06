extends Control

var dialog = "You obtained "
onready var dialog_pivot = $DialogPivot
var finished = false


func _ready():
	self.visible = false
	
	pass
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and finished:
		get_tree().paused = false
		queue_free()
		

		
func load_dialog(skill_name):
	get_tree().paused = true
	self.visible = true
	$DialogPivot/DialogBox/RichTextLabel.bbcode_text = dialog + skill_name
	$DialogPivot/DialogBox/RichTextLabel.percent_visible = 0
	$DialogPivot/DialogBox/Tween.interpolate_property(
		$DialogPivot/DialogBox/RichTextLabel, "percent_visible", 0, 1, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$DialogPivot/DialogBox/Tween.start()
pass
 
func _on_tween_completed(object, key):
	finished = true
	pass # Replace with function body.
