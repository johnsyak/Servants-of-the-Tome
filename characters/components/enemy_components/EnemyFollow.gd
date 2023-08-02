extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var movement_speed:float = 100.0
var movement_target
var navigation_agent
var chase: bool = false

func set_movement_target():
	movement_target = enemy.movement_target
	
func set_target_position():
	navigation_agent.target_position = movement_target.position

func set_navigation_target():
	await get_tree().physics_frame
	set_movement_target()
	set_target_position()


func set_navigation_agent():
	await get_tree().physics_frame
	navigation_agent = enemy.navigation_agent
	call_deferred("actor_setup")

func enter():
	chase = true
	set_navigation_agent()
	set_navigation_target()

func actor_setup():
	set_movement_target()

func _on_target_timer_timeout():
	if movement_target == null:
		return
	if navigation_agent == null:
		return
	if !chase:
		Transitioned.emit(self, "EnemyIdle")
		return
	set_target_position()
	
func update(delta):
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = enemy.global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var new_velocity: Vector2 = (next_path_position - current_agent_position).normalized() * movement_speed

	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		enemy.velocity = enemy.velocity.move_toward(new_velocity, 1)
		
	
func _on_sonar_body_exited(body):
	chase = false
	
