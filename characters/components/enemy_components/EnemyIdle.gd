extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed:=10.0

var move_direction: Vector2
var wander_time: float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
	
func enter():
	enemy.idle_timer.start()
	randomize_wander()
	
func exit():
	enemy.idle_timer.stop()
	
func update(delta: float):
	if wander_time >0:
		wander_time -= delta
	else:
		randomize_wander()
		
func physics_update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed

func _on_sonar_area_entered(area):
	Transitioned.emit(self, "EnemyFollow")

func _on_idle_timer_timeout():
	Transitioned.emit(self, "MoveToTome")
