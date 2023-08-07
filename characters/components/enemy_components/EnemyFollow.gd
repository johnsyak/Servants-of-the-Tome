extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var movement_speed:float = 200.0

var movement_target
var navigation_agent

func set_movement_target():
	movement_target = enemy.movement_target
	
func set_target_position():
	navigation_agent.target_position = movement_target.position

func actor_setup():
	set_movement_target()

func _on_target_timer_timeout():
	set_target_position()

func set_navigation_target():
	set_movement_target()
	set_target_position()
	
func set_navigation_agent():
	navigation_agent = enemy.navigation_agent
	call_deferred("actor_setup")

func enter():
	set_navigation_agent()
	set_navigation_target()
	enemy.follow_timer.start()

func update(delta):
	if navigation_agent.is_navigation_finished():
		if enemy.follow_timer.is_stopped():
			Transitioned.emit(self, "EnemyIdle")
		return

	var current_agent_position: Vector2 = enemy.global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = lerp(enemy.velocity, ((next_path_position - current_agent_position).normalized() * movement_speed), 0.05)

	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		enemy.velocity = enemy.velocity.move_toward(new_velocity, 1)
			
func _on_sonar_area_entered(area):
	enemy.follow_timer.start()

func _on_sonar_area_exited(area):
	enemy.follow_timer.stop()

func _on_attack_area_area_entered(area):
	Transitioned.emit(self, "EnemyAttack")

func _on_wall_collision_body_entered(body):
	var vel = enemy.velocity.length()
	if enemy.velocity.length() < 50:
		pass

func _on_wall_collision_body_exited(body):
	pass # Replace with function body.
