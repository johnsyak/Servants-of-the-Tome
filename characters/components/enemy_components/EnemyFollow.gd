extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D

func enter():
	enemy.follow_timer.start()

func update(delta):
	if enemy.navigation_agent.is_navigation_finished():
		if enemy.follow_timer.is_stopped():
			Transitioned.emit(self, "EnemyIdle")
		return

	var current_agent_position: Vector2 = enemy.global_position
	var next_path_position: Vector2 = enemy.navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = (next_path_position - current_agent_position).normalized() * enemy.run_speed

	if enemy.navigation_agent.avoidance_enabled:
		enemy.navigation_agent.set_velocity(new_velocity)
	else:
		enemy.velocity = enemy.velocity.move_toward(new_velocity, 1)

func exit():
	enemy.follow_timer.stop()

func _on_sonar_area_exited(area):
	enemy.follow_timer.stop()

func _on_sonar_area_entered(area):
	enemy.follow_timer.start()

func _on_attack_area_area_entered(area):
	Transitioned.emit(self, "EnemyAttack")

func _on_wall_collision_body_entered(body):
	var vel = enemy.velocity.length()
	if enemy.velocity.length() < 100:
		return
	Transitioned.emit(self, "Breakthrough")
	
func _on_target_timer_timeout():
	enemy.navigation_agent.target_position = enemy.movement_target.position

