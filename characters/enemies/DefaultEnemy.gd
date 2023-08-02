extends CharacterBody2D


@export var movement_target: CharacterBody2D
@export var navigation_agent: NavigationAgent2D

signal enemy_follow

func _physics_process(delta):
	move_and_slide()
#
