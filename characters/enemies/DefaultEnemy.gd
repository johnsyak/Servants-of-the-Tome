extends CharacterBody2D


@export var movement_target: CharacterBody2D
@export var navigation_agent: NavigationAgent2D
@export var follow_timer: Timer
@export var attack_timer: Timer
@export var idle_timer: Timer
@export var rotation_speed = 50

@onready var default_target = get_tree().get_nodes_in_group("tome")[0]

signal enemy_follow

func _physics_process(delta):
	var rotation_target = default_target
	if movement_target != null:
		rotation_target = movement_target
	var direction = (rotation_target.global_position - global_position)
	var angleTo = $Sprite2D.transform.x.angle_to(direction)
	$Sprite2D.rotate(sign(angleTo) * min(delta * rotation_speed, abs(angleTo)))
	move_and_slide()
#
func _ready():
	follow_timer.stop()
	attack_timer.stop()
	idle_timer.start()

func _on_sonar_area_entered(area):
	movement_target = 	area.owner
