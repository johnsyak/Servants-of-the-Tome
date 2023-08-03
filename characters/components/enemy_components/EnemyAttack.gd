extends State
class_name enemy_attack

@export var enemy: CharacterBody2D

func enter():
	print("animation plays here: ATTACK!")
	enemy.attack_timer.start()
	
func update(delta):
	pass
	
func exit():
	pass

func _on_attack_area_area_exited(area):
	Transitioned.emit(self, "EnemyFollow")
	enemy.attack_timer.stop()

func _on_attack_timer_timeout():
	print("animation plays here: ATTACK!")
