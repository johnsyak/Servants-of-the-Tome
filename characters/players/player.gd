extends CharacterBody2D

@export var speed: int = 60
@export var run_speed: float = 1.5

func _handle_input():
	var move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = move_direction*speed
	if Input.is_action_pressed("run"):
		velocity = move_direction*speed*run_speed
		
func _physics_process(delta):
	_handle_input()
	move_and_slide()
