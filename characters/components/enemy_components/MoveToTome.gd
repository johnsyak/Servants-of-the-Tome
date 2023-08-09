extends State
class_name move_to_tome

@export var enemy: CharacterBody2D

func enter():
	enemy.movement_target = enemy.default_target
	enemy.follow_timer.start()
	
func exit():
	enemy.follow_timer.stop()

func update(_delta: float):
	if enemy.navigation_agent.is_navigation_finished():
		if enemy.follow_timer.is_stopped():
			Transitioned.emit(self, "EnemyIdle")
			return

	var current_agent_position: Vector2 = enemy.global_position
	var next_path_position: Vector2 = enemy.navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = (next_path_position - current_agent_position).normalized() * enemy.walk_speed

	if enemy.navigation_agent.avoidance_enabled:
		enemy.navigation_agent.set_velocity(new_velocity)
	else:
		enemy.velocity = enemy.velocity.move_toward(new_velocity, 1)

func physics_update(_delta: float):
	pass

func _on_sonar_area_entered(area):
	Transitioned.emit(self, "EnemyFollow")

func _on_follow_timer_timeout():
	enemy.navigation_agent.target_position = enemy.movement_target.position
