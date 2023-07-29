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
	var collision:KinematicCollision2D = move_and_collide(velocity * delta)
	#this will only work for direction down for now
	breakSouthWall(collision)


func breakSouthWall(collision:KinematicCollision2D):
	if collision:
		var collision_point = returnSnappedCollisionPoint(collision.get_position())
		var coord1 = Vector2(collision_point.x, collision_point.y)
		var coord2 = Vector2(collision_point.x - 16, collision_point.y)
		var coord3 = Vector2(collision_point.x, collision_point.y+16)
		var coord4 = Vector2(collision_point.x - 16, collision_point.y + 16)
		print("Point 1: "+str(coord1))
		print("Point 2: "+str(coord2))
		print("Point 3: "+str(coord3))
		print("Point 4: "+str(coord4))
		var collider = collision.get_collider()
		var coords = [coord1, coord2, coord3, coord4]
		emit_signal("break_block", coords)


		

func returnSnappedCollisionPoint(collision_point) -> Vector2:	
	return Vector2(snapped(collision_point.x, 16), snapped(collision_point.y, 16))
			

