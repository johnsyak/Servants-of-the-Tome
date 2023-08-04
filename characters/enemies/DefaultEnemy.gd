extends CharacterBody2D


@export var movement_target: CharacterBody2D
@export var navigation_agent: NavigationAgent2D
@export var follow_timer: Timer
@export var attack_timer: Timer

signal enemy_follow

func _physics_process(delta):
	move_and_slide()
#
func _ready():
	follow_timer.stop()
	attack_timer.stop()

func _on_sonar_area_entered(area):
	movement_target = 	area.owner
