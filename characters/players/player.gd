extends CharacterBody2D

@export var speed: int = 50
@export var run_speed: float = 2
var move_direction

signal break_block(coords)

func _handle_input():
	move_direction = Input.get_vector("left", "right", "up", "down")
	velocity = move_direction*speed
	if Input.is_action_pressed("run"):
		velocity = move_direction*speed*run_speed
	move_and_slide()
		
func _physics_process(delta):
	
	_handle_input()
	#this will only work for direction down for now
	breakSouthWall(move_and_collide(velocity * delta))


func breakSouthWall(collision:KinematicCollision2D):
	pass
#	if collision:
#		emit_signal("break_block", snap_to_grid(collision.get_position()))

func snap_to_grid(collision:Vector2) -> Vector2:
	return Vector2(snapped(collision.x, 16), snapped(collision.y, 16))




