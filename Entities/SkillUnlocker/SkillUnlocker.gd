extends Area2D

#ADD SKILL UNLOCKER TO SCENE
#SET SKILL NAME -> THIS IS THE NAME WILL SHOW UP IN THE DIALOG
#SELECT ONLY ONE CHECKBOX TO SET WHICH SKILL DO YOU WANT
#DO NOT SELECT BOTH CHECKBOX
#ADD THE SKILL UNLOCKER TO THE SCENE

var bodies
var dialog_scene
export (String) var skill_name
export var dash_skill : bool
export var double_jump_skill : bool

func _ready():
	dialog_scene = $DialogSkillUnlocker
pass	

func _process(_delta):
	
	bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Player"):
			$CollisionShape2D.disabled = true
			dialog_scene.load_dialog(skill_name)
			self.position = body.get_global_transform().get_origin()
			if dash_skill:
				body.dash_skill = true
			if double_jump_skill:
				body.double_jump_skill = true
			pass
