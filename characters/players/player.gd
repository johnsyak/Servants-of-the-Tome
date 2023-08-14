extends CharacterBody2D

@export var speed: int = 50
@export var run_speed: float = 2
@export var cooldown = 0.025
@export var bullet_scene : PackedScene

var can_shoot = true
var move_direction

signal break_block(coords)

func start():
	$GunCooldown.wait_time = cooldown

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$GunCooldown.start()
	var b = bullet_scene.instantiate()
	owner.add_child(b)
	#b.position = position
	#b.velocity = Vector2.RIGHT.rotated(rotation)
	b.transform = $Hands.global_transform
	
func _on_gun_cooldown_timeout():
	can_shoot = true
	
func _handle_input():
	move_direction = Input.get_vector("left", "right", "up", "down")
	velocity = move_direction*speed
	if Input.is_action_pressed("run"):
		velocity = move_direction*speed*run_speed
	if Input.is_action_pressed("shoot"):
		shoot()
	move_and_slide()
		
func _physics_process(delta):
	_handle_input()
