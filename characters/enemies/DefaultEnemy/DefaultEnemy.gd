extends CharacterBody2D

@export var movement_speed:float = 200.0

@export var pathing_component: PathingComponent


func _physics_process(delta):
	velocity = pathing_component.velocity
	move_and_slide()
