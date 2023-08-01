extends CharacterBody2D


@export var movement_target: CharacterBody2D
@export var navigation_agent: NavigationAgent2D
#var movement_speed

func _physics_process(delta):
	move_and_slide()
#
#func _ready():
#	navigation_agent.path_desired_distance = 4.0
#	navigation_agent.target_desired_distance = 4.0
#	call_deferred("actor_setup")
#
#func actor_setup():
#	await get_tree().physics_frame
#	set_movement_target(movement_target.position)
#
#func set_movement_target(target_point: Vector2):
#	navigation_agent.target_position = target_point
#
#func _physics_process(delta):
##	if navigation_agent.is_navigation_finished():
##		return
#
#	var current_agent_position: Vector2 = global_position
#	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
#
#	var new_velocity: Vector2 = (next_path_position - current_agent_position).normalized() * movement_speed
#
#	if $NavigationAgent2D.avoidance_enabled:
#		$NavigationAgent2D.set_velocity(new_velocity)
#	else:
#		velocity = velocity.move_toward(new_velocity, 1)
#		move_and_slide()
#
#
#func _on_target_timer_timeout():
#	set_movement_target(movement_target.position)
