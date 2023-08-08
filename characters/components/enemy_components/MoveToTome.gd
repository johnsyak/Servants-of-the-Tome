extends State
class_name move_to_tome

@export var enemy: CharacterBody2D
@export var speed:float = 10.0

func enter():
	pass
	
func exit():
	pass

func update(_delta: float):
	enemy.velocity = enemy.position.direction_to(enemy.movement_target.position) * speed

func physics_update(_delta: float):
	pass

func _on_sonar_area_entered(area):
	Transitioned.emit(self, "EnemyFollow")
