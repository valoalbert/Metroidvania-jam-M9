extends Area2D

#ADD SKILL UNLOCKER TO SCENE
#SET SKILL NAME -> THIS IS THE NAME WILL SHOW UP IN THE DIALOG
#SELECT ONLY ONE CHECKBOX TO SET WHICH SKILL DO YOU WANT
#DO NOT SELECT BOTH CHECKBOX
#ADD THE SKILL UNLOCKER TO THE SCENE
#IF PLAYER HAS THAT SKILL, SKILL UNLOCKER WILL BE REMOVED FROM SCENE TREE

var bodies
var dialog_scene
var sprite
var skill_name : String
export var dash_skill : bool
export var double_jump_skill : bool
export var boots_skill : bool
export var wall_jump_skill : bool

func _ready():
	dialog_scene = $CanvasLayer/DialogSkillUnlocker
	sprite = $Sprite
	
	if dash_skill:
		if SceneSwitcher.dash_skill:
			queue_free()
		else:
			sprite.texture = load("res://Entities/SkillUnlocker/dash_skill.png")
			skill_name = "The Dash MOD"
	if double_jump_skill:
		if SceneSwitcher.double_jump_skill:
			queue_free()
		else:
			sprite.texture = load("res://Entities/SkillUnlocker/double_jump_skill.png")
			skill_name = "The Double Jump MOD"
	if wall_jump_skill:
		if SceneSwitcher.wall_jump_skill:
			queue_free()
		else:
			sprite.texture = load("res://Entities/SkillUnlocker/wall_jump_skill.png")
			skill_name = "The Wall jump MOD"
#	if boots_skill:
#		sprite.texture = load("res://Entities/SkillUnlocker/boots_skill.png")
#		skill_name = "The Magnetic boots MOD"
#
	$AnimationPlayer.play("icon_anim")
pass	

func _process(_delta):
	
	bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Player"):
			$CollisionShape2D.disabled = true
			dialog_scene.load_dialog(skill_name, sprite.texture)
			if dash_skill:
				body.dash_skill = true
			if double_jump_skill:
				body.double_jump_skill = true
			if wall_jump_skill:
				body.wall_jump_skill = true

			pass
