extends CharacterBody2D

@export var speed: int = 50
@export var run_speed: float = 1.5
var move_direction

signal break_block(coords)

func _handle_input():
	move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = move_direction*speed
	if Input.is_action_pressed("run"):
		velocity = move_direction*speed*run_speed
		
func _physics_process(delta):
	
	_handle_input()
	#this will only work for direction down for now
	breakSouthWall(move_and_collide(velocity * delta))


func breakSouthWall(collision:KinematicCollision2D):
	if collision:
		emit_signal("break_block", snap_to_grid(collision.get_position()))

func snap_to_grid(collision:Vector2) -> Vector2:
	return Vector2(snapped(collision.x, 16), snapped(collision.y, 16))
