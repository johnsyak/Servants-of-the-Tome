extends State
class_name breakthrough

signal breakthrough

@export var enemy: CharacterBody2D
@export var marker: Marker2D

func enter():
	pass
	#enemy.velocity = Vector2.ZERO
	
func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass

func _on_wall_collision_body_entered(body):
	var coords = marker.get_global_position()
	var coords2 = body.get_global_position()
	emit_signal("breakthrough", coords)


